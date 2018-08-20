package game.mediator.gui.popup.resourcepanel
{
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.PopupResourceList;
   import starling.display.DisplayObjectContainer;
   
   public class PopupResourcePanelMediator
   {
       
      
      private var _panel:PopupResourceList;
      
      public function PopupResourcePanelMediator()
      {
         super();
         _panel = new PopupResourceList();
      }
      
      public function get panel() : PopupResourceList
      {
         return _panel;
      }
      
      public function setMediator(param1:ClipBasedPopup, param2:DisplayObjectContainer) : void
      {
         if(!param1.popupMediator)
         {
            return;
         }
         if(param1.popupMediator.resourcePanelList)
         {
            param2.addChild(_panel);
            _panel.resourceList = param1.popupMediator.resourcePanelList;
            _panel.resourceList.stashSource = param1.stashParams;
         }
         else if(panel.parent)
         {
            panel.parent.removeChild(panel);
            if(_panel.resourceList)
            {
               _panel.resourceList.dispose();
            }
         }
      }
   }
}
