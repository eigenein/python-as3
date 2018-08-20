package game.view.gui.overlay.offer
{
   import starling.core.Starling;
   import starling.display.DisplayObject;
   
   public class SpecialOfferSideBarFadeAway
   {
       
      
      private var sideBar:SpecialOfferSideBar;
      
      private var target:DisplayObject;
      
      public function SpecialOfferSideBarFadeAway(param1:SpecialOfferSideBar, param2:DisplayObject)
      {
         super();
         this.sideBar = param1;
         this.target = param2;
         param2.touchable = false;
         if(param1)
         {
            Starling.juggler.tween(param2,0.6,{
               "alpha":0,
               "onComplete":onComplete,
               "transition":"easeOut"
            });
         }
         else
         {
            Starling.juggler.tween(param2,0.6,{
               "alpha":0,
               "onComplete":onComplete,
               "transition":"easeOut"
            });
         }
      }
      
      private function onComplete() : void
      {
         target.removeFromParent(true);
      }
   }
}
