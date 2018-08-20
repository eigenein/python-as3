package game.view.popup.artifactinfo
{
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class TitanArtifactInfoPopupMediator extends PopupMediator
   {
       
      
      public var artifact:TitanArtifactDescription;
      
      public function TitanArtifactInfoPopupMediator(param1:Player, param2:TitanArtifactDescription)
      {
         super(param1);
         this.artifact = param2;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArtifactInfoPopup(this);
         return _popup;
      }
      
      public function action_navigate_store() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.TITAN_ARTIFACT_MERCHANT,Stash.click("store",_popup.stashParams));
         close();
      }
      
      public function action_navigate_chest() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.TITAN_ARTIFACT_CHEST,Stash.click("chest",_popup.stashParams));
         close();
      }
   }
}
