package game.battle.gui.teambuffs
{
   import battle.skills.TeamEffect;
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.gui.tutorial.CircularProgressBar;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class BattleTeamEffectIcon
   {
      
      public static const ALPHA_FADE_IN_DURATION:Number = 0.2;
      
      public static const ALPHA_FADE_AWAY_DURATION:Number = 0.25;
       
      
      private var duration:Number;
      
      private var effect:TeamEffect;
      
      private var iconAsset:String;
      
      private var tooltip:TooltipVO;
      
      private var _isDisposed:Boolean = false;
      
      private var _graphics:Sprite;
      
      private var clip:BattleTeamEffectIconClip;
      
      private var progressBar:CircularProgressBar;
      
      private var progressBarBack:CircularProgressBar;
      
      private var bars:Vector.<CircularProgressBar>;
      
      private var isActive:Boolean = true;
      
      public function BattleTeamEffectIcon(param1:TeamEffect, param2:String)
      {
         tooltip = new TooltipVO(TooltipTextView,null);
         _graphics = new Sprite();
         bars = new Vector.<CircularProgressBar>();
         super();
         this.effect = param1;
         this.iconAsset = param2;
         duration = param1.getDurationLeft();
         var _loc6_:Texture = AssetStorage.rsx.battle_interface.getTexture("angleGradientRed");
         bars.push(new CircularProgressBar(_loc6_,55,55,15662848,18,20,19));
         bars.push(new CircularProgressBar(_loc6_,55,55,16777215,18,22,20));
         bars.push(new CircularProgressBar(_loc6_,55,55,8973824,18,25,21));
         var _loc12_:int = 0;
         var _loc11_:* = bars;
         for each(var _loc5_ in bars)
         {
            _loc5_.x = -8;
            _loc5_.y = -8;
            _loc5_.progress = 1;
         }
         var _loc7_:String = param2.replace("artifact_","");
         clip = AssetStorage.rsx.battle_interface.createTeamEffectIcon();
         var _loc8_:int = clip.image.image.width;
         var _loc10_:int = clip.image.image.height;
         clip.image.image.texture = AssetStorage.rsx.rune_icons.getTexture(_loc7_ + "_small");
         clip.image.image.readjustSize();
         _loc12_ = 1;
         clip.image.image.scaleY = _loc12_;
         clip.image.image.scaleX = _loc12_;
         clip.image.image.x = int(0 + (_loc8_ - clip.image.image.width) * 0.5);
         clip.image.image.y = int(0 + (_loc10_ - clip.image.image.height) * 0.5);
         _graphics.addChild(clip.bg.graphics);
         _graphics.addChild(clip.graphics);
         advanceTime(0);
         var _loc9_:Number = param1.skillCast.skill.prime.c;
         var _loc3_:String = ColorUtils.hexToRGBFormat(15581850);
         var _loc4_:String = ColorUtils.hexToRGBFormat(16777215);
         tooltip.hintData = _loc3_ + Translate.translate("UI_POPUP_BATTLE_TEMPORARY_BUFF") + " " + _loc4_ + Translate.translate("LIB_BATTLESTATDATA_" + _loc7_.toUpperCase()) + " +" + int(_loc9_);
         TooltipHelper.addTooltip(_graphics,tooltip);
         var _loc14_:int = 0;
         var _loc13_:* = bars;
         for each(_loc5_ in bars)
         {
            _graphics.addChildAt(_loc5_,1);
         }
      }
      
      public function dispose() : void
      {
         _isDisposed = true;
         _graphics.removeFromParent(true);
      }
      
      public function get isDisposed() : Boolean
      {
         return _isDisposed;
      }
      
      public function get graphics() : DisplayObject
      {
         return _graphics;
      }
      
      public function get isAttackersTeam() : Boolean
      {
         return effect.targetTeam.direction > 0;
      }
      
      public function disable() : void
      {
         isActive = false;
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(isActive)
         {
            tickActive(param1);
         }
         else
         {
            tickFading(param1);
         }
      }
      
      protected function tickFading(param1:Number) : void
      {
         graphics.alpha = graphics.alpha - param1 / 0.25;
         if(graphics.alpha <= 0)
         {
            dispose();
         }
      }
      
      protected function tickActive(param1:Number) : void
      {
         var _loc3_:* = Number(effect.getDurationLeft());
         var _loc5_:int = 0;
         var _loc4_:* = bars;
         for each(var _loc2_ in bars)
         {
            _loc2_.progress = _loc3_ / duration;
         }
         if(_loc3_ <= 0)
         {
            isActive = false;
            _loc3_ = 0;
         }
         else if(graphics.alpha < 1)
         {
            graphics.alpha = graphics.alpha + param1 / 0.2;
            if(graphics.alpha > 1)
            {
               graphics.alpha = 1;
            }
         }
         clip.label.text = _loc3_.toFixed(1);
      }
   }
}
