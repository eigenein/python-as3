package game.battle.view.text
{
   import engine.core.animation.ZSortedSprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.BattleFonts;
   import game.battle.view.hero.HeroView;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.tooltip.TooltipTextView;
   
   public class BattleTextAnimationController
   {
       
      
      private var pool:Vector.<BattleFloatingText>;
      
      private var texts:Vector.<BattleFloatingText>;
      
      private const fonts:BattleFonts = AssetStorage.rsx.battle_interface.fonts;
      
      public const container:ZSortedSprite = new ZSortedSprite();
      
      public const removedTextContainer:ZSortedSprite = new ZSortedSprite();
      
      public const MISSED:BattleFloatingTextStyle = new BattleFloatingTextStyle(16,3342523,fonts.miss,1,-90);
      
      public const DODGED:BattleFloatingTextStyle = new BattleFloatingTextStyle(16,12255283,fonts.dodge,1,-90);
      
      public const DAMAGE_PHYSICAL:BattleFloatingTextStyle = new BattleFloatingTextStyle(22,15597568,fonts.physical);
      
      public const DAMAGE_MAGIC:BattleFloatingTextStyle = new BattleFloatingTextStyle(22,15597568,fonts.magic);
      
      public const DAMAGE_PURE:BattleFloatingTextStyle = new BattleFloatingTextStyle(22,15597568,fonts.pure,0.495);
      
      public const CRIT_DAMAGE_PHYSICAL:BattleFloatingTextStyle = new BattleFloatingTextStyle(32,15597568,fonts.physicalCrit);
      
      public const CRIT_DAMAGE_MAGIC:BattleFloatingTextStyle = new BattleFloatingTextStyle(32,15597568,fonts.magicCrit);
      
      public const CRIT_DAMAGE_PURE:BattleFloatingTextStyle = new BattleFloatingTextStyle(32,15597568,fonts.pureCrit);
      
      public const HEAL:BattleFloatingTextStyle = new BattleFloatingTextStyle(22,3403264,fonts.heal);
      
      public const ENERGY:BattleFloatingTextStyle = new BattleFloatingTextStyle(18,16763904,fonts.energy,0.8,50);
      
      public const ENERGY_SMALL:BattleFloatingTextStyle = new BattleFloatingTextStyle(14,16763904,fonts.energy,0.495,30);
      
      public const ENERGY_YELLOW:BattleFloatingTextStyle = new BattleFloatingTextStyle(18,16763904,fonts.energyYellow,0.8,50);
      
      public const ENERGY_YELLOW_SMALL:BattleFloatingTextStyle = new BattleFloatingTextStyle(14,16763904,fonts.energyYellow,0.495,300);
      
      public const DEBUG:BattleFloatingTextStyle = new BattleFloatingTextStyle(14,3403264,AssetStorage.font.getAsset("Officina14"),1.25,-90,1);
      
      public function BattleTextAnimationController()
      {
         pool = new Vector.<BattleFloatingText>();
         texts = new Vector.<BattleFloatingText>();
         super();
         container.z = 10000;
      }
      
      public function dispose() : void
      {
         removedTextContainer.dispose();
         texts.length = 0;
         pool.length = 0;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = texts.length;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = texts[_loc4_];
            if(_loc3_ != 0)
            {
               texts[_loc4_ - _loc3_] = _loc5_;
            }
            _loc5_.phase = _loc5_.phase + param1 / _loc5_.style.duration;
            if(_loc5_.phase >= 1)
            {
               pool.push(_loc5_);
               if(_loc5_.crossLine)
               {
                  _loc5_.crossLine.graphics.removeFromParent(true);
                  _loc5_.crossLine = null;
               }
               TooltipHelper.removeTooltip(_loc5_);
               removedTextContainer.addChild(_loc5_);
               _loc3_++;
            }
            else
            {
               _loc5_.x = _loc5_.x - (1 - _loc5_.phase) * (1 - _loc5_.phase) * (1 - _loc5_.phase) * param1 * _loc5_.movement;
               _loc5_.y = _loc5_.y - (1 - _loc5_.phase) * param1 * _loc5_.yMovement;
               _loc5_.alpha = 1 - _loc5_.phase * _loc5_.phase * _loc5_.phase;
            }
            _loc4_++;
         }
         if(_loc3_ != 0)
         {
            texts.length = _loc2_ - _loc3_;
         }
      }
      
      public function createFloating(param1:HeroView, param2:String, param3:BattleFloatingTextStyle, param4:String = null) : void
      {
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc5_:Point = param1.hpTextSpawnPosition;
         var _loc6_:Number = 130;
         _loc5_.x = _loc5_.x + (param1.position.x - _loc6_ * 0.5);
         _loc5_.y = _loc5_.y + param1.position.y;
         findFreeSpot(_loc5_,_loc6_,10,param1.direction,param3.layerToFindFreeSpot);
         var _loc9_:Number = param3.movement * param1.direction;
         if(pool.length == 0)
         {
            _loc8_ = new BattleFloatingText(_loc5_.x + _loc6_ * 0.5,_loc5_.y,param2,param3,_loc9_,0);
         }
         else
         {
            _loc8_ = pool.pop();
            _loc8_.init(_loc5_.x + _loc6_ * 0.5,_loc5_.y,param2,param3,_loc9_,0);
         }
         if(param4)
         {
            _loc7_ = new TooltipVO(TooltipTextView,param4);
            TooltipHelper.addTooltip(_loc8_,_loc7_);
         }
         container.addChild(_loc8_);
         texts.push(_loc8_);
      }
      
      public function createFloatingEnergy(param1:HeroView, param2:String, param3:BattleFloatingTextStyle, param4:Number, param5:Number, param6:Boolean) : void
      {
         var _loc9_:* = null;
         var _loc7_:Point = param1.hpTextSpawnPosition;
         var _loc8_:* = 20;
         _loc7_.x = _loc7_.x + (param1.position.x - _loc8_ * 0.5 - param1.direction * param4);
         _loc7_.y = _loc7_.y + (param1.position.y + 60);
         findFreeSpot(_loc7_,_loc8_,10,param1.direction);
         var _loc10_:Number = param3.movement * param1.direction;
         if(pool.length == 0)
         {
            _loc9_ = new BattleFloatingText(_loc7_.x + _loc8_ * 0.5,_loc7_.y,param2,param3,_loc10_,param5);
         }
         else
         {
            _loc9_ = pool.pop();
            _loc9_.init(_loc7_.x + _loc8_ * 0.5,_loc7_.y,param2,param3,_loc10_,param5);
         }
         if(param6)
         {
            _loc9_.addCrossLine();
         }
         container.addChild(_loc9_);
         texts.push(_loc9_);
      }
      
      public function findFreeSpot(param1:Point, param2:Number = 150, param3:Number = 10, param4:int = 1, param5:int = 0) : void
      {
         while(positionIsCaptured(param1,param2,param3,param5))
         {
            param1.y = param1.y - param3;
            param1.x = param1.x - param3 * 0.3 * param4;
         }
      }
      
      protected function positionIsCaptured(param1:Point, param2:Number = 200, param3:Number = 30, param4:int = 0) : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
