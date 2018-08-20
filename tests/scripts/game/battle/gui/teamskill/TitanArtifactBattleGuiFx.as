package game.battle.gui.teamskill
{
   import battle.proxy.displayEvents.TitanArtifactGuiFxEvent;
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.battle.view.BattleGraphicsProvider;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.animation.BattleFx;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.DisplayObject;
   
   public class TitanArtifactBattleGuiFx extends BattleGuiFx
   {
       
      
      private var clip:TitanArtifactBattleGuiFxClip;
      
      private var iconFx:BattleFx;
      
      private var timeToAddIcon:Number = 0.3;
      
      private var asset:BattleGraphicsProvider;
      
      private var event:TitanArtifactGuiFxEvent;
      
      public function TitanArtifactBattleGuiFx(param1:TitanArtifactGuiFxEvent, param2:BattleGraphicsProvider)
      {
         clip = new TitanArtifactBattleGuiFxClip();
         super();
         this.event = param1;
         this.asset = param2;
         var _loc4_:String = param1.team.direction > 0?"titan_spirit_intro":"titan_spirit_intro_defenders";
         AssetStorage.rsx.battle_interface.initGuiClip(clip,_loc4_);
         clip.tf_title.text = Translate.translate("UI_BATTLE_TITAN_SPIRIT_TITLE_" + String(param1.element).toUpperCase());
         var _loc5_:Object = {
            "earth":52224,
            "water":39423,
            "fire":16724736
         };
         var _loc3_:uint = _loc5_[param1.element];
         clip.tf_name.text = ColorUtils.hexToRGBFormat(_loc3_) + Translate.translate("UI_BATTLE_TITAN_SPIRIT_NAME_" + String(param1.element).toUpperCase());
         clip.tf_percent.text = int(param1.progress * 100) + "%";
         clip.doPlayWithEnterFrame = false;
         clip.playback.playOnce();
         clip.playback.signal_completed.add(handler_completed);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clip.graphics.removeFromParent(true);
         clip.dispose();
      }
      
      override public function get graphics() : DisplayObject
      {
         return clip.graphics;
      }
      
      override public function advanceTime(param1:Number) : void
      {
         var _loc2_:* = null;
         super.advanceTime(param1);
         clip.advanceTime(param1);
         if(iconFx)
         {
            iconFx.advanceTime(param1);
         }
         if(timeToAddIcon > 0)
         {
            timeToAddIcon = timeToAddIcon - param1;
            if(timeToAddIcon <= 0)
            {
               _loc2_ = asset.getCommonEffect("titan_artifact_" + event.element + "_head");
               iconFx = new BattleFx(true,0);
               iconFx.skin = _loc2_.createFrontSkin();
               clip.container_icon.container.addChild(iconFx.graphics);
            }
         }
      }
      
      private function handler_completed() : void
      {
         dispose();
      }
   }
}
