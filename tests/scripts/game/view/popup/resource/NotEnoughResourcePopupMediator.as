package game.view.popup.resource
{
   import game.data.storage.resource.ObtainNavigatorType;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupMediator;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class NotEnoughResourcePopupMediator extends PopupMediator
   {
       
      
      private var obtainNavigatorType:ObtainNavigatorType;
      
      public function NotEnoughResourcePopupMediator(param1:ObtainNavigatorType)
      {
         super(null);
         this.obtainNavigatorType = param1;
      }
      
      public function get windowTitle() : String
      {
         return obtainNavigatorType.not_enough_title;
      }
      
      public function get contentText() : String
      {
         return obtainNavigatorType.not_enough_message;
      }
      
      public function get actionLabel() : String
      {
         return obtainNavigatorType.navString;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new NotEnoughResourcePopup(this);
         return _popup;
      }
      
      public function navigate() : void
      {
         if(Game.instance.navigator.canNavigateToCoinObtainType(obtainNavigatorType))
         {
            GamePopupManager.closeAll();
         }
         else
         {
            close();
         }
         Game.instance.navigator.navigateToCoinObtainType(obtainNavigatorType,Stash.click("go",_popup.stashParams));
      }
   }
}
