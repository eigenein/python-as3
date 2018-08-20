package game.view.gui.homescreen
{
   import game.sound.SoundSource;
   
   public class ButtonHoverSound
   {
       
      
      protected var musicSource:SoundSource;
      
      private var fadeInDuration:Number;
      
      private var fadeOutDuration:Number;
      
      private var _easingIn:Number = 0;
      
      private var _easingOut:Number = 0;
      
      public function ButtonHoverSound(param1:Number, param2:Number, param3:SoundSource)
      {
         super();
         this.fadeInDuration = param1;
         this.fadeOutDuration = param2;
         this.musicSource = param3;
         param3.volume.setValue(0);
      }
      
      public function set easingIn(param1:Number) : void
      {
         _easingIn = param1;
      }
      
      public function set easingOut(param1:Number) : void
      {
         _easingOut = param1;
      }
      
      public function set looping(param1:Boolean) : void
      {
         musicSource.looping = true;
      }
      
      public function mouseOver() : void
      {
         if(!musicSource.isPlaying)
         {
            musicSource.play();
         }
         musicSource.volume.easing = _easingIn;
         musicSource.volume.tweenTo(1,fadeInDuration);
      }
      
      public function mouseOut() : void
      {
         if(musicSource.isPlaying)
         {
            musicSource.stopWhenVolumeZero();
         }
         musicSource.volume.easing = _easingOut;
         musicSource.volume.tweenTo(0,fadeOutDuration);
      }
   }
}
