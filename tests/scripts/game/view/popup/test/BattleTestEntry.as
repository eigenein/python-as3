package game.view.popup.test
{
   public class BattleTestEntry
   {
       
      
      public var seed:int;
      
      public var desc:String;
      
      public var result:String;
      
      public var phpLog:String;
      
      public var log:String = "";
      
      public function BattleTestEntry()
      {
         super();
      }
      
      public function get testString() : String
      {
         return "addTest(\'" + seed + "\',\'" + desc + "\',\'" + result + "\');";
      }
      
      public function toJSON(param1:*) : Object
      {
         return {
            "desc":desc,
            "result":result
         };
      }
      
      public function print() : void
      {
         trace(testString);
         trace("==================================================================================");
         trace("FLASH ============================================================================");
         trace(log);
         trace("PHP ==============================================================================");
      }
   }
}
