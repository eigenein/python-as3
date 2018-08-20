package game.battle.view
{
   import game.battle.view.animation.IBattleFadableAnimation;
   import game.battle.view.systems.BattleUpdateSystem;
   
   public class BattleFadableAnimations extends BattleUpdateSystem
   {
       
      
      private var alpha:Number = 1;
      
      private var alphaFadeAwaySpeed:Number = 0;
      
      private var temporaryAnimations:Vector.<IBattleFadableAnimation>;
      
      public function BattleFadableAnimations()
      {
         temporaryAnimations = new Vector.<IBattleFadableAnimation>();
         super(null);
      }
      
      override protected function get collection() : Vector.<*>
      {
         return temporaryAnimations as Vector.<*>;
      }
      
      override public function getComponentToHandle(param1:BattleSceneObject) : *
      {
         return param1.entry as IBattleFadableAnimation;
      }
      
      public function endBattle() : void
      {
         var _loc1_:* = 1;
         alphaFadeAwaySpeed = 1 / _loc1_;
      }
      
      public function cleanUpBattle() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function advanceTime(param1:Number) : void
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
