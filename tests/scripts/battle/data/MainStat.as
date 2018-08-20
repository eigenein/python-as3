package battle.data
{
   import flash.Boot;
   
   public class MainStat
   {
      
      public static var intelligence:MainStat = new MainStat("intelligence");
      
      public static var agility:MainStat = new MainStat("agility");
      
      public static var strength:MainStat = new MainStat("strength");
       
      
      public var name:String;
      
      public function MainStat(param1:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         name = param1;
      }
      
      public static function fromString(param1:String) : MainStat
      {
         if(param1 == MainStat.intelligence.name)
         {
            return MainStat.intelligence;
         }
         if(param1 == MainStat.agility.name)
         {
            return MainStat.agility;
         }
         if(param1 == MainStat.strength.name)
         {
            return MainStat.strength;
         }
         return null;
      }
      
      public function toString() : String
      {
         return name;
      }
      
      public function toJSON(param1:*) : String
      {
         return name;
      }
   }
}
