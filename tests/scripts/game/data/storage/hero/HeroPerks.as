package game.data.storage.hero
{
   public class HeroPerks
   {
      
      public static const FEMALE:uint = 1;
      
      public static const MALE:uint = 2;
      
      public static const ARCHER:uint = 3;
       
      
      private var data:Array;
      
      public function HeroPerks(param1:Array)
      {
         super();
         data = param1;
      }
      
      public function get isMale() : Boolean
      {
         var _loc1_:int = 0;
         if(data)
         {
            _loc1_ = 0;
            while(_loc1_ < data.length)
            {
               if(data[_loc1_] == 1)
               {
                  return false;
               }
               _loc1_++;
            }
         }
         return true;
      }
   }
}
