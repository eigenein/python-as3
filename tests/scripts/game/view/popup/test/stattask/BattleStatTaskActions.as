package game.view.popup.test.stattask
{
   import battle.utils.Version;
   import game.view.popup.test.BattleTestStatsParams;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class BattleStatTaskActions
   {
       
      
      private var e:BattleStatTaskExecutor;
      
      private var _heroId:int;
      
      public function BattleStatTaskActions(param1:BattleStatTaskExecutor)
      {
         super();
         this.e = param1;
      }
      
      public function setGrades(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.charAt(0) == "{")
         {
            _loc3_ = JSON.parse(param1);
            e.attGrade.deserialize(_loc3_);
            e.defGrade.deserialize(_loc3_);
         }
         else
         {
            _loc2_ = new BattleTestStatsParams();
            _loc2_.deserialize(param1);
            e.attGrade.copyFrom(_loc2_.gradeLeft);
            e.defGrade.copyFrom(_loc2_.gradeRight);
         }
      }
      
      public function setAttackers(param1:String) : void
      {
         e.attackerIds = getIds(param1);
      }
      
      public function setDefenders(param1:String) : void
      {
         e.defenderIds = getIds(param1);
      }
      
      public function printProgress(param1:String, param2:uint) : void
      {
         if(e.progressReport.value.length > 0)
         {
            e.progressReport.value = e.progressReport.value + "\n";
         }
         e.progressReport.value = e.progressReport.value + (ColorUtils.hexToRGBFormat(param2) + param1 + ColorUtils.hexToRGBFormat(15058588));
      }
      
      public function runBattles(param1:int) : void
      {
         e.startBattles(param1);
         printProgress(e.attGrade.toStringShort(),7829367);
         if(e.attGrade.isEqual(e.defGrade))
         {
            printProgress(e.defGrade.toStringShort(),7829367);
         }
      }
      
      public function print(param1:String = "") : void
      {
         e.resultReport.value = e.resultReport.value + param1;
      }
      
      public function println(param1:String = "") : void
      {
         if(e.resultReport.value.length > 0)
         {
            e.resultReport.value = e.resultReport.value + "\n";
         }
         e.resultReport.value = e.resultReport.value + param1;
      }
      
      public function clearResult(param1:String) : void
      {
         e.resultReport.value = "";
      }
      
      public function clear(param1:String) : void
      {
         e.testSetup.statistics.clear();
         e.testSetup.statisticsA.clear();
         e.testSetup.statisticsD.clear();
         e.testSetup.clear();
      }
      
      public function setHero(param1:String) : void
      {
         _heroId = int(param1);
      }
      
      public function getHeroWinrate(param1:String) : void
      {
         var _loc3_:Vector.<int> = getIds(param1);
         if(e.resultReport.value.length > 0)
         {
            e.resultReport.value = e.resultReport.value + "\n";
         }
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc2_++;
            e.resultReport.value = e.resultReport.value + ((_loc2_ == 0?"":"\t") + e.testSetup.statistics.getHeroWinrate(_loc4_));
         }
      }
      
      public function getAttackersWinrate(param1:String) : void
      {
         var _loc2_:String = (e.testSetup.attackersWinCount / e.testSetup.succeededCount * 100).toFixed(1);
         e.resultReport.value = e.resultReport.value + (_loc2_ + "\n");
      }
      
      public function getWinrates(param1:String) : void
      {
         e.resultReport.value = e.resultReport.value + e.testSetup.statistics.getShortReport();
      }
      
      public function battleVersion(param1:String) : void
      {
         Version.current = int(param1);
      }
      
      private function getIds(param1:String) : Vector.<int>
      {
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc5_:Vector.<int> = new Vector.<int>();
         if(param1 == null || param1.length == 0)
         {
            _loc5_.push(_heroId);
         }
         else
         {
            _loc2_ = param1.split(",");
            var _loc10_:int = 0;
            var _loc9_:* = _loc2_;
            for each(var _loc3_ in _loc2_)
            {
               _loc6_ = _loc3_.split(" ");
               var _loc8_:int = 0;
               var _loc7_:* = _loc6_;
               for each(var _loc4_ in _loc6_)
               {
                  if(int(_loc4_) != 0 || _loc4_ == "0")
                  {
                     _loc5_.push(int(_loc4_));
                  }
               }
            }
         }
         return _loc5_;
      }
   }
}
