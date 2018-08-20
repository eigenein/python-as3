package game.view.popup.artifactinfo
{
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class ArtifactRecipeItemInfoPopupMediator extends PopupMediator
   {
       
      
      public var item:InventoryItemDescription;
      
      public function ArtifactRecipeItemInfoPopupMediator(param1:Player, param2:InventoryItemDescription)
      {
         super(param1);
         this.item = param2;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ArtifactRecipeItemInfoPopup(this);
         return _popup;
      }
      
      public function action_navigate_expeditions() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.EXPEDITIONS,Stash.click("arena",_popup.stashParams));
         close();
      }
      
      public function action_navigate_chest() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.ARTIFACT_CHEST,Stash.click("chest",_popup.stashParams));
         close();
      }
   }
}
