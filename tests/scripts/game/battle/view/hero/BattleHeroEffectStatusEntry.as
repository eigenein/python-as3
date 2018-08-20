package game.battle.view.hero
{
   import battle.proxy.ViewTransform;
   import flash.geom.Rectangle;
   import game.battle.controller.entities.BattleEffect;
   import game.battle.view.animation.BattleFx;
   
   public class BattleHeroEffectStatusEntry
   {
       
      
      public var fx:BattleFx;
      
      public var effect:BattleEffect;
      
      public var bounds:Rectangle;
      
      public var m:ViewTransform;
      
      public var angle:Number;
      
      public var alpha:Number;
      
      private var bar:BattleHeroEffectStatusBar;
      
      public function BattleHeroEffectStatusEntry(param1:BattleFx, param2:BattleHeroEffectStatusBar, param3:BattleEffect)
      {
         super();
         this.fx = param1;
         this.bar = param2;
         this.effect = param3;
         param3.signal_dispose.add(handler_disposeEffect);
         bounds = param1.graphics.getBounds(null);
         m = new ViewTransform();
         angle = 0;
         alpha = 1;
      }
      
      public function unsubscribe() : void
      {
         effect.signal_dispose.remove(handler_disposeEffect);
      }
      
      private function handler_disposeEffect() : void
      {
         effect.signal_dispose.remove(handler_disposeEffect);
         bar.removeStatus(this);
      }
   }
}
