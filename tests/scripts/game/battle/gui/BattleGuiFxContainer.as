package game.battle.gui
{
   import game.battle.gui.teamskill.BattleGuiFx;
   import starling.display.DisplayObjectContainer;
   
   public class BattleGuiFxContainer
   {
       
      
      private var elements:Vector.<BattleGuiFx>;
      
      private var _graphics:DisplayObjectContainer;
      
      public function BattleGuiFxContainer(param1:DisplayObjectContainer)
      {
         super();
         this._graphics = param1;
         elements = new Vector.<BattleGuiFx>();
      }
      
      public function get graphics() : DisplayObjectContainer
      {
         return _graphics;
      }
      
      public function advanceTime(param1:Number, param2:Number) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function add(param1:BattleGuiFx) : void
      {
         elements.push(param1);
         _graphics.addChild(param1.graphics);
      }
   }
}
