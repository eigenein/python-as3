package battle.log
{
   import flash.Boot;
   
   public class DamageEventType
   {
       
      
      public var name:String;
      
      public var locale:String;
      
      public var id:int;
      
      public function DamageEventType(param1:int = 0, param2:String = undefined, param3:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         id = param1;
         name = param2;
         locale = param3;
      }
   }
}
