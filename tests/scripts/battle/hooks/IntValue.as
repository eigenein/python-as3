package battle.hooks
{
   import flash.Boot;
   
   public class IntValue
   {
       
      
      public var value:int;
      
      public function IntValue(param1:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         value = param1;
      }
      
      public static function create(param1:Number) : IntValue
      {
         return new IntValue(int(param1));
      }
      
      public function dispose() : void
      {
      }
   }
}
