package game.view.popup.resource
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.mechanic.MechanicDescription;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupMediator;
   import game.view.popup.PopupBase;
   
   public class CopyofNotEnoughResourcePopupMediator extends PopupMediator
   {
       
      
      private var _mechanic:MechanicDescription;
      
      private var _contentText:String;
      
      private var _windowTitle:String;
      
      public function CopyofNotEnoughResourcePopupMediator(param1:MechanicDescription, param2:String, param3:String)
      {
         super(null);
         _mechanic = param1;
         _contentText = param3;
         _windowTitle = param2;
      }
      
      public function get windowTitle() : String
      {
         return _windowTitle;
      }
      
      public function get contentText() : String
      {
         return _contentText;
      }
      
      public function get actionLabel() : String
      {
         return Translate.translate("LIB_MECHANIC_NAVIGATE_" + _mechanic.type.toUpperCase());
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new CopyofNotEnoughResourcePopup(this);
         return _popup;
      }
      
      public function navigate() : void
      {
         GamePopupManager.closeAll();
         Game.instance.navigator.navigateToMechanic(_mechanic,_popup.stashParams);
      }
   }
}
