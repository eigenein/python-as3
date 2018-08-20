package game.sound
{
   import flash.media.SoundChannel;
   
   public class PlayingSound
   {
       
      
      public var endTime:Number;
      
      public var channel:SoundChannel;
      
      public var source:SoundSource;
      
      public function PlayingSound()
      {
         super();
      }
      
      public function isOver(param1:SoundManager) : Boolean
      {
         return endTime >= param1.currentTime;
      }
   }
}
