package game.battle.controller
{
   import game.battle.controller.statistic.BattleDamageStatistics;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   
   public class MultiBattleResult
   {
       
      
      private var stars:int = -1;
      
      private var isVictory:Boolean;
      
      private var battleIsOver:Boolean;
      
      private var progressData:Vector.<*>;
      
      private var logData:Vector.<String>;
      
      public var attackers:Vector.<UnitEntryValueObject>;
      
      public var defenders:Vector.<UnitEntryValueObject>;
      
      public const battleStatistics:BattleDamageStatistics = new BattleDamageStatistics();
      
      public function MultiBattleResult()
      {
         super();
         progressData = new Vector.<*>();
         logData = new Vector.<String>();
      }
      
      public function get victory() : Boolean
      {
         return isVictory;
      }
      
      public function get timesUp() : Boolean
      {
         return !battleIsOver;
      }
      
      public function get b() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = progressData;
         for each(var _loc1_ in progressData)
         {
            if(_loc1_.b)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get result() : Object
      {
         return {
            "win":isVictory,
            "stars":stars
         };
      }
      
      public function get progress() : Object
      {
         return progressData;
      }
      
      public function get hasResult() : Boolean
      {
         return stars != -1;
      }
      
      public function addBattleProgress(param1:*) : void
      {
         progressData.push(param1);
      }
      
      public function addBattleLog(param1:String) : void
      {
         logData.push(param1);
      }
      
      public function setVictory(param1:int) : void
      {
         this.stars = param1;
         isVictory = true;
      }
      
      public function setDefeat(param1:Boolean) : void
      {
         this.stars = 0;
         this.battleIsOver = param1;
         isVictory = false;
      }
      
      public function getBattleLog() : String
      {
         return logData.join("\n");
      }
      
      public function parseDefenders(param1:*) : void
      {
         if(!defenders)
         {
            defenders = new Vector.<UnitEntryValueObject>();
         }
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            defenders.push(UnitUtils.createEntryValueObjectFromRawData(_loc2_));
         }
      }
      
      public function parseAttackers(param1:*) : void
      {
         if(!attackers)
         {
            attackers = new Vector.<UnitEntryValueObject>();
         }
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            attackers.push(UnitUtils.createEntryValueObjectFromRawData(_loc2_));
         }
      }
   }
}
