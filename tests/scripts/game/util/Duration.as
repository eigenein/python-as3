package game.util
{
   public class Duration extends TimeDelayAbstract
   {
       
      
      private var _durationInSeconds:Number;
      
      public function Duration(param1:int)
      {
         _durationInSeconds = param1;
         super();
      }
      
      override public function get timeLeft() : int
      {
         return _durationInSeconds;
      }
      
      public function setValue(param1:int) : void
      {
         _durationInSeconds = param1;
      }
   }
}
