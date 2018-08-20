package game.sound
{
   import com.progrestar.framework.ares.extension.sounds.ClipSound;
   
   public class MusicSource extends SoundSource
   {
       
      
      public function MusicSource(param1:ClipSound = null, param2:Boolean = false, param3:Number = -1)
      {
         if(param3 == -1)
         {
            param3 = NaN;
         }
         super(param1,param2,param3);
      }
   }
}
