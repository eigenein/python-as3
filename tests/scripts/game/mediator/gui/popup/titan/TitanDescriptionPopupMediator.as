package game.mediator.gui.popup.titan
{
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class TitanDescriptionPopupMediator extends PopupMediator
   {
       
      
      private var titan:PlayerTitanListValueObject;
      
      public function TitanDescriptionPopupMediator(param1:Player, param2:PlayerTitanListValueObject)
      {
         super(param1);
         this.titan = param2;
      }
      
      public function get isUltra() : Boolean
      {
         return titanDesc.details.type == "ultra";
      }
      
      public function get titanDesc() : TitanDescription
      {
         return titan.titan;
      }
      
      public function get titanName() : String
      {
         return titan.titan.name;
      }
      
      public function get titanElement() : String
      {
         return titan.titan.details.element;
      }
      
      public function get fragmentsAmount() : int
      {
         return titan.fragmentCount;
      }
      
      public function get fragmentsAmountMax() : int
      {
         return titan.maxFragments;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanDescriptionPopup(this);
         return _popup;
      }
      
      public function action_navigateToDungeon() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.CLAN_DUNGEON,Stash.click("dungeon",_popup.stashParams));
         close();
      }
      
      public function action_navigateToSummoningCircle() : void
      {
         Game.instance.navigator.navigateToSummoningCircle(Stash.click("summoning_circle",_popup.stashParams));
         close();
      }
   }
}
