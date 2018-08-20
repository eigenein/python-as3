package battle.skills
{
   import flash.Boot;
   
   public class SkillCondition
   {
       
      
      public var _name:String;
      
      public var _method:Function;
      
      public function SkillCondition(param1:Function = undefined, param2:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _method = param1;
         _name = param2;
      }
      
      public function name() : String
      {
         return _name;
      }
      
      public function method() : Function
      {
         return _method;
      }
      
      public function check() : Boolean
      {
         return Boolean(_method());
      }
   }
}
