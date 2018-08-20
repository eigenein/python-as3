package battle.data
{
   import flash.Boot;
   
   public class InputEventDescription
   {
      
      public static var ACT_CAST:String = "cast";
      
      public static var ACT_CUSTOM:String = "custom";
      
      public static var ACT_TEAM_CUSTOM:String = "teamCustom";
      
      public static var ACT_AUTO_TOGGLED:String = "auto";
       
      
      public var time:Number;
      
      public var id:int;
      
      public var i:int;
      
      public var hero:int;
      
      public var act:String;
      
      public function InputEventDescription(param1:Number = 0.0, param2:String = undefined, param3:int = -1, param4:int = 0, param5:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         time = param1;
         act = param2;
         if(param3 != -1)
         {
            hero = param3;
         }
         i = param4;
         id = param5;
      }
      
      public function toJSON(param1:*) : *
      {
         return {
            "time":time,
            "hero":hero,
            "id":id,
            "act":act,
            "i":i
         };
      }
   }
}
