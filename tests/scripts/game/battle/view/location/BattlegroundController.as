package game.battle.view.location
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import engine.core.animation.Animation;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import game.assets.battle.BattlegroundAsset;
   import game.battle.view.BattleScene;
   
   public class BattlegroundController
   {
      
      private static const LAYER_Z:Vector.<Number> = new <Number>[500,-500,-1000,-1500,-2000,-2500];
      
      private static const LAYER_SCALES:Vector.<Number> = new <Number>[1.66667,1,0.68583,0.4,0.1,0];
      
      private static const DEFAULT_LAYER_WIDTH:Number = 2400;
      
      private static const FIRST_BATTLE_SIDE_OFFSET:Number = 400;
      
      private static const LAST_BATTLE_SIDE_OFFSET:Number = 100;
      
      private static const BATTLES_COUNT:Number = 3;
      
      private static const DEFAULT_LOOPED_SCREEN_WIDTH:int = 1000;
       
      
      private var scene:BattleScene;
      
      private var battlegroundAsset:BattlegroundAsset;
      
      private var battlesPositionOffset:Point;
      
      private const currentBattlePosition:Point = new Point();
      
      private var layers:Vector.<BattlegroundLayer>;
      
      private var fogLayers:Vector.<BattlegroundFogLayer>;
      
      public function BattlegroundController(param1:BattleScene)
      {
         layers = new Vector.<BattlegroundLayer>();
         fogLayers = new Vector.<BattlegroundFogLayer>();
         super();
         this.scene = param1;
         var _loc2_:Number = 950;
         battlesPositionOffset = new Point(_loc2_);
      }
      
      public function dispose() : void
      {
         if(battlegroundAsset)
         {
            battlegroundAsset.dropUsage();
            battlegroundAsset = null;
         }
      }
      
      public function get battlePosition() : Point
      {
         return currentBattlePosition;
      }
      
      public function get previousBattleOffset() : Point
      {
         return battlesPositionOffset;
      }
      
      public function nextBattle() : void
      {
         currentBattlePosition.x = currentBattlePosition.x + battlesPositionOffset.x;
         currentBattlePosition.y = currentBattlePosition.y + battlesPositionOffset.y;
      }
      
      public function advanceTime(param1:Number) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function setBattlegroundAsset(param1:BattlegroundAsset) : void
      {
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         if(battlegroundAsset == param1)
         {
            return;
         }
         if(battlegroundAsset)
         {
            clearLayers();
            battlegroundAsset.dropUsage();
         }
         if(param1)
         {
            this.battlegroundAsset = param1;
            battlegroundAsset.addUsage();
            if(battlegroundAsset.noScrolling)
            {
               createLayersWithoutScrolling(battlegroundAsset);
               currentBattlePosition.x = 0;
            }
            else
            {
               createLayers(battlegroundAsset,6);
               currentBattlePosition.x = 400 + param1.sideOffset;
            }
            if(param1.fogOfDepth && param1.fogOfDepth.completed)
            {
               _loc7_ = param1.fogOfDepth.clip;
               _loc3_ = 6;
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc6_ = (_loc4_ - _loc3_ * 0.2) * 45;
                  _loc5_ = 1 / (1 - _loc6_ * 0.0015);
                  _loc2_ = new Matrix(1,0,0,1 - _loc4_ / _loc3_ * 0.4,0,_loc6_);
                  addFogLayer(_loc7_,_loc2_,_loc6_,true);
                  _loc4_++;
               }
            }
            if(param1.animatedLayers && param1.animatedLayers.completed)
            {
               _loc7_ = param1.animatedLayers.clip;
               _loc3_ = 6;
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc6_ = (_loc4_ - _loc3_ * 0.2) * 45;
                  _loc5_ = 1 / (1 - _loc6_ * 0.0015);
                  _loc2_ = new Matrix(_loc5_,0,0,_loc5_,0,_loc6_);
                  addFogLayer(_loc7_,_loc2_,_loc6_ + 5,false);
                  _loc4_++;
               }
            }
         }
      }
      
      protected function clearLayers() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function createLayers(param1:BattlegroundAsset, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc6_:* = null;
         var _loc5_:ClipAsset = param1.data;
         var _loc3_:String = param1.mainClip;
         _loc4_ = 0;
         while(_loc4_ < param2)
         {
            _loc6_ = _loc5_.getClipByName(_loc3_ + _loc4_);
            if(_loc6_)
            {
               addLayer(_loc6_,LAYER_Z[_loc4_],LAYER_SCALES[_loc4_]);
            }
            else
            {
               layers[_loc4_] = null;
            }
            _loc4_++;
         }
      }
      
      protected function createLayersWithoutScrolling(param1:BattlegroundAsset) : void
      {
         var _loc2_:ClipAsset = param1.data;
         var _loc4_:Clip = _loc2_.getClipByName(param1.mainClip);
         addLayer(_loc4_,LAYER_Z[1],1);
         var _loc3_:Clip = _loc2_.getClipByName(param1.mainClip + "_front");
         if(_loc3_)
         {
            addLayer(_loc3_,LAYER_Z[0],1);
         }
      }
      
      protected function addFogLayer(param1:Clip, param2:Matrix, param3:Number, param4:Boolean) : void
      {
         var _loc5_:Boolean = false;
         _loc5_ = true;
         if(param1 == null)
         {
            return;
         }
         var _loc6_:BattlegroundFogLayer = new BattlegroundFogLayer();
         _loc6_.matrix = param2;
         _loc6_.lockedScreenPosition = param4;
         _loc6_.animation = new Animation(param1,_loc6_.matrix,param3);
         _loc6_.animated = _loc6_.animation.hasAnimation;
         if(_loc6_.animated)
         {
            _loc6_.animation.advanceTimeTo(_loc6_.animation.length * Math.random());
         }
         else
         {
            _loc6_.animation.advanceTime(0);
         }
         scene.animationTarget.addChild(_loc6_.animation.graphics);
         fogLayers.push(_loc6_);
      }
      
      protected function addLayer(param1:Clip, param2:Number, param3:Number) : void
      {
         var _loc4_:BattlegroundLayer = new BattlegroundLayer();
         _loc4_.scale = param3;
         _loc4_.matrix = new Matrix(1,0,0,1,0,-scene.graphics.y);
         _loc4_.animation = new Animation(param1,_loc4_.matrix,param2);
         layers.push(_loc4_);
         if(param2 > 0)
         {
            scene.layers.foreground.addChild(_loc4_.animation.graphics);
         }
         else
         {
            scene.layers.background.addChildAt(_loc4_.animation.graphics,0);
         }
      }
   }
}
