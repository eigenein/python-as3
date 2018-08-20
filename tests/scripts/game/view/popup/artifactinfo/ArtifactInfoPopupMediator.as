package game.view.popup.artifactinfo
{
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.artifactstore.ArtifactStorePopupMediator;
   
   public class ArtifactInfoPopupMediator extends PopupMediator
   {
       
      
      private var hero:HeroDescription;
      
      public var artifact:ArtifactDescription;
      
      public function ArtifactInfoPopupMediator(param1:Player, param2:ArtifactDescription, param3:HeroDescription)
      {
         super(param1);
         this.artifact = param2;
         this.hero = param3;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ArtifactInfoPopup(this);
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
      
      public function action_navigate_merchant() : void
      {
         var _loc1_:ArtifactStorePopupMediator = new ArtifactStorePopupMediator(GameModel.instance.player,hero);
         _loc1_.open(Stash.click("merchant",_popup.stashParams));
         close();
      }
   }
}
