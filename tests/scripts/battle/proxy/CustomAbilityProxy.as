package battle.proxy
{
   import battle.Team;
   import flash.Boot;
   
   public class CustomAbilityProxy
   {
       
      
      public var type:String;
      
      public var team:Team;
      
      public var progress:Function;
      
      public var fx:String;
      
      public var action:CustomManualAction;
      
      public function CustomAbilityProxy(param1:Team = undefined, param2:CustomManualAction = undefined, param3:String = undefined, param4:String = undefined, param5:Function = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         team = param1;
         action = param2;
         type = param3;
         fx = param4;
         progress = param5;
      }
      
      public function getProgress() : Number
      {
         return Number(progress());
      }
   }
}
