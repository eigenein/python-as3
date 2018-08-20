package game.battle.view.hero
{
   import battle.proxy.ViewTransform;
   import com.progrestar.framework.ares.starling.ClipSkin;
   import engine.core.utils.VectorUtil;
   import game.battle.controller.entities.BattleEffect;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.animation.BattleFx;
   import starling.display.Sprite;
   
   public class BattleHeroEffectStatusBar
   {
      
      public static const ALPHA_FADE_AWAY_DURATION:Number = 0.25;
      
      private static var X_GAP:Number = 80;
      
      private static var Y_OFFSET:Number = -220;
      
      private static var SCALE:Number = 0.7;
      
      private static var D_SCALE_PER_EFFECT:Number = 0.05;
      
      private static var POSITION_UPDATE_RATE:Number = 0.2;
       
      
      private var active:Vector.<BattleHeroEffectStatusEntry>;
      
      private var fadingAway:Vector.<BattleHeroEffectStatusEntry>;
      
      public const graphics:Sprite = new Sprite();
      
      public function BattleHeroEffectStatusBar()
      {
         active = new Vector.<BattleHeroEffectStatusEntry>();
         fadingAway = new Vector.<BattleHeroEffectStatusEntry>();
         super();
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = active.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = active[_loc5_];
            updatePosition(_loc2_,_loc5_,POSITION_UPDATE_RATE);
            _loc2_.fx.advanceTime(param1);
            _loc5_++;
         }
         _loc4_ = fadingAway.length;
         var _loc3_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            var _loc6_:* = fadingAway[_loc5_];
            fadingAway[_loc5_ - _loc3_] = _loc6_;
            _loc2_ = _loc6_;
            _loc2_.alpha = _loc2_.alpha - param1 / 0.25;
            _loc2_.fx.advanceTime(param1);
            _loc2_.fx.graphics.alpha = _loc2_.alpha;
            if(_loc2_.alpha <= 0)
            {
               _loc3_++;
               graphics.removeChild(_loc2_.fx.graphics);
            }
            _loc5_++;
         }
         fadingAway.length = fadingAway.length - _loc3_;
      }
      
      public function addStatus(param1:BattleEffect) : void
      {
         var _loc4_:EffectGraphicsProvider = param1.fxProvider;
         var _loc2_:BattleFx = new BattleFx(false,0);
         _loc2_.skin = new ClipSkin(_loc4_.status,_loc4_.clipAssetDataProvider);
         _loc2_.loop = _loc4_.statusLoop;
         this.graphics.addChild(_loc2_.graphics);
         _loc2_.advanceTime(0);
         var _loc3_:BattleHeroEffectStatusEntry = new BattleHeroEffectStatusEntry(_loc2_,this,param1);
         updatePosition(_loc3_,active.length,1);
         active.push(_loc3_);
      }
      
      function removeStatus(param1:BattleHeroEffectStatusEntry) : void
      {
         fadingAway.push(param1);
         VectorUtil.remove(active,param1);
      }
      
      public function fadeAway() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function cleanUpBattle() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:int = fadingAway.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = fadingAway[_loc2_];
            graphics.removeChild(_loc1_.fx.graphics);
            _loc2_++;
         }
         fadingAway.length = 0;
      }
      
      protected function updatePosition(param1:BattleHeroEffectStatusEntry, param2:int, param3:Number) : void
      {
         var _loc5_:int = active.length;
         var _loc7_:Number = SCALE - (_loc5_ - 1) * D_SCALE_PER_EFFECT;
         var _loc4_:Number = -Y_OFFSET * 0.5;
         var _loc6_:Number = Y_OFFSET * 0.5;
         var _loc9_:Number = (param2 - (_loc5_ - 1) / 2) * X_GAP * _loc7_ / _loc4_;
         param1.angle = param1.angle * (1 - param3) + param3 * _loc9_;
         var _loc8_:ViewTransform = param1.m;
         var _loc10_:* = _loc7_;
         _loc8_.d = _loc10_;
         _loc8_.a = _loc10_;
         _loc10_ = 0;
         _loc8_.b = _loc10_;
         _loc8_.c = _loc10_;
         _loc8_.tx = Math.sin(param1.angle) * _loc4_;
         _loc8_.ty = _loc6_ - Math.cos(param1.angle) * _loc4_;
         param1.fx.selfTransform = param1.m;
      }
   }
}
