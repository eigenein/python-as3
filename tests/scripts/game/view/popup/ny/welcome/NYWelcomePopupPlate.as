package game.view.popup.ny.welcome
{
   import game.view.gui.components.ClipButton;
   import starling.filters.ColorMatrixFilter;
   
   public class NYWelcomePopupPlate extends ClipButton
   {
       
      
      public function NYWelcomePopupPlate()
      {
         super();
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = param1 == "hover";
         if(isInHover != _loc3_)
         {
            isInHover = _loc3_;
            if(isInHover)
            {
               if(true || !hoverFilter)
               {
                  if(hoverFilter)
                  {
                     hoverFilter.dispose();
                  }
                  hoverFilter = new ColorMatrixFilter();
                  hoverFilter.adjustBrightness(0.05);
               }
               if(_container.filter != hoverFilter)
               {
                  if(defaultFilter != _container.filter)
                  {
                     if(defaultFilter)
                     {
                        defaultFilter.dispose();
                     }
                     defaultFilter = _container.filter;
                  }
                  _container.filter = hoverFilter;
               }
            }
            else
            {
               _container.filter = defaultFilter;
            }
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
   }
}
