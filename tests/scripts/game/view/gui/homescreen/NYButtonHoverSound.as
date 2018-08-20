package game.view.gui.homescreen
{
   import game.sound.SoundSource;
   
   public class NYButtonHoverSound extends ButtonHoverSound
   {
       
      
      private var _nyWindowOpen:Boolean;
      
      private var _mouseOver:Boolean;
      
      public function NYButtonHoverSound(param1:Number, param2:Number, param3:SoundSource)
      {
         super(param1,param2,param3);
         easingIn = 1;
         easingOut = 0;
      }
      
      public function nyWindowOpen() : void
      {
         _nyWindowOpen = true;
         toggle(_nyWindowOpen || _mouseOver);
      }
      
      public function nyWindowClosed() : void
      {
         _nyWindowOpen = false;
         toggle(_nyWindowOpen || _mouseOver);
      }
      
      override public function mouseOver() : void
      {
         _mouseOver = true;
         toggle(_nyWindowOpen || _mouseOver);
      }
      
      override public function mouseOut() : void
      {
         _mouseOver = false;
         toggle(_nyWindowOpen || _mouseOver);
      }
      
      protected function toggle(param1:Boolean) : void
      {
         if(param1)
         {
            super.mouseOver();
         }
         else
         {
            super.mouseOut();
         }
      }
   }
}
