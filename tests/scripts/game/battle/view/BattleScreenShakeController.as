package game.battle.view
{
   import game.model.GameModel;
   import game.model.user.settings.PlayerSettingsParameter;
   import starling.display.DisplayObject;
   
   public class BattleScreenShakeController
   {
       
      
      private var displayObject:DisplayObject;
      
      private var x:Number;
      
      private var y:Number;
      
      private var dx:Number = 0;
      
      private var dy:Number = 0;
      
      private const shakeEntries:Vector.<BattleScreenShakeEntry> = new Vector.<BattleScreenShakeEntry>();
      
      private const settingScreenShake:PlayerSettingsParameter = GameModel.instance.player.settings.screenShake;
      
      public function BattleScreenShakeController()
      {
         super();
      }
      
      public function add(param1:Number, param2:int = 1, param3:Number = 0) : void
      {
         var _loc4_:int = 0;
         applyShake(param1);
         _loc4_ = 1;
         while(_loc4_ < param2)
         {
            shakeEntries.push(new BattleScreenShakeEntry(param1,_loc4_ / (param2 - 1) * param3));
            _loc4_++;
         }
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
      
      public function setDisplayObject(param1:DisplayObject) : void
      {
         this.displayObject = param1;
         x = param1.x;
         y = param1.y;
      }
      
      protected function applyShake(param1:Number) : void
      {
         var _loc2_:* = settingScreenShake.getValue();
         if(_loc2_ is Boolean)
         {
            if(!_loc2_)
            {
               return;
            }
         }
         else
         {
            param1 = param1 * _loc2_;
         }
         if(Math.abs(dx) < param1)
         {
            dx = 2 * (Math.random() - 0.5) * param1;
         }
         if(Math.abs(dy) < param1)
         {
            dy = 2 * (Math.random() - 0.5) * param1;
         }
      }
   }
}

class BattleScreenShakeEntry
{
    
   
   public var intensity:Number;
   
   public var timeLeft:Number;
   
   function BattleScreenShakeEntry(param1:Number, param2:Number)
   {
      super();
      this.intensity = param1;
      this.timeLeft = param2;
   }
}
