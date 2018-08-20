package game.view.popup.common
{
   import game.mediator.gui.popup.PopupStashEventParams;
   import starling.display.DisplayObject;
   
   public interface IPopupSideBarBlock
   {
       
      
      function initialize(param1:PopupStashEventParams) : void;
      
      function dispose() : void;
      
      function get graphics() : DisplayObject;
      
      function get popupOffset() : Number;
      
      function get popupGap() : Number;
      
      function get popupSide() : PopupSideBarSide;
   }
}
