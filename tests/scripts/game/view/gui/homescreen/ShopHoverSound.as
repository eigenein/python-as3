package game.view.gui.homescreen
{
   import game.sound.SoundSource;
   
   public class ShopHoverSound extends ButtonHoverSound
   {
       
      
      private var _shopOpen:Boolean;
      
      private var _mouseOver:Boolean;
      
      public function ShopHoverSound(param1:Number, param2:Number, param3:SoundSource)
      {
         super(param1,param2,param3);
         easingIn = 1;
         easingOut = 0;
      }
      
      public function shopOpen() : void
      {
         _shopOpen = true;
         toggle(_shopOpen || _mouseOver);
      }
      
      public function shopClosed() : void
      {
         _shopOpen = false;
         toggle(_shopOpen || _mouseOver);
      }
      
      override public function mouseOver() : void
      {
         _mouseOver = true;
         toggle(_shopOpen || _mouseOver);
      }
      
      override public function mouseOut() : void
      {
         _mouseOver = false;
         toggle(_shopOpen || _mouseOver);
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
