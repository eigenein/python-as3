package game.mechanics.titan_arena.mediator
{
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.ShopDescriptionStorage;
   import game.mechanics.titan_arena.popup.TitanValleyPopup;
   import game.mediator.gui.RedMarkerGlobalMediator;
   import game.mediator.gui.RedMarkerState;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class TitanValleyPopupMediator extends PopupMediator
   {
       
      
      private var _signal_spiritsUpdate:Signal;
      
      public function TitanValleyPopupMediator(param1:Player)
      {
         _signal_spiritsUpdate = new Signal();
         super(param1);
         param1.titans.signal_titanArtifactEvolveStar.add(handler_titanArtifactEvolve);
      }
      
      override protected function dispose() : void
      {
         player.titans.signal_titanArtifactEvolveStar.remove(handler_titanArtifactEvolve);
         super.dispose();
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_coin(DataStorage.coin.getByIdent("titan_arena"));
         _loc1_.requre_coin(DataStorage.coin.getByIdent("titan_token"));
         _loc1_.requre_consumable(DataStorage.consumable.getItemsByType("titanArtifactChestKey")[0]);
         _loc1_.requre_consumable(DataStorage.consumable.getById(53) as ConsumableDescription);
         _loc1_.requre_starmoney();
         return _loc1_;
      }
      
      public function get signal_spiritsUpdate() : Signal
      {
         return _signal_spiritsUpdate;
      }
      
      public function get titanArenaRewardMarkerState() : RedMarkerState
      {
         return RedMarkerGlobalMediator.instance.titan_arena_reward;
      }
      
      public function get titanArenaPointsRewardMarkerState() : RedMarkerState
      {
         return RedMarkerGlobalMediator.instance.titan_arena_points_reward;
      }
      
      public function get titanArtifactsMarkerState() : RedMarkerState
      {
         return RedMarkerGlobalMediator.instance.titan_artifacts;
      }
      
      public function get titanSpiritArtifactsMarkerState() : RedMarkerState
      {
         return RedMarkerGlobalMediator.instance.titan_spirit_artifacts;
      }
      
      public function get titanArtifactChestMarkerState() : RedMarkerState
      {
         return RedMarkerGlobalMediator.instance.titanArtifactChest;
      }
      
      public function get totemStar_fire() : int
      {
         return _getTotemStar(4002);
      }
      
      public function get totemStar_water() : int
      {
         return _getTotemStar(4001);
      }
      
      public function get totemStar_earth() : int
      {
         return _getTotemStar(4003);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanValleyPopup(this);
         return _popup;
      }
      
      public function action_navigate_hall_of_fame() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.TITAN_ARENA_HALL_OF_FAME,Stash.click("titan_arena_hall_of_fame",_popup.stashParams));
      }
      
      public function action_navigate_arena() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.TITAN_ARENA,Stash.click("titan_arena",_popup.stashParams));
      }
      
      public function action_navigate_merchant() : void
      {
         var _loc1_:ShopDescription = DataStorage.shop.getByIdent(ShopDescriptionStorage.IDENT_TITAN_ARTIFACT_SHOP);
         Game.instance.navigator.navigateToShop(_loc1_,_popup.stashParams);
      }
      
      public function action_navigate_altar() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.TITAN_ARTIFACT_CHEST,Stash.click("titan_altar",_popup.stashParams));
      }
      
      public function action_navigate_temple() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.TITAN_ARTIFACT,Stash.click("titan_artifact",_popup.stashParams));
      }
      
      public function action_navigate_spirit_fire() : void
      {
         var _loc1_:PlayerTitanArtifact = player.titans.getSpiritArtifactById(4002);
         PopupList.instance.dialog_titan_spirit_artifacts(_loc1_,Stash.click("dialog_titan",_popup.stashParams));
      }
      
      public function action_navigate_spirit_water() : void
      {
         var _loc1_:PlayerTitanArtifact = player.titans.getSpiritArtifactById(4001);
         PopupList.instance.dialog_titan_spirit_artifacts(_loc1_,Stash.click("dialog_titan",_popup.stashParams));
      }
      
      public function action_navigate_spirit_earth() : void
      {
         var _loc1_:PlayerTitanArtifact = player.titans.getSpiritArtifactById(4003);
         PopupList.instance.dialog_titan_spirit_artifacts(_loc1_,Stash.click("dialog_titan",_popup.stashParams));
      }
      
      private function _getTotemStar(param1:int) : int
      {
         var _loc2_:PlayerTitanArtifact = player.titans.getSpiritArtifactById(param1);
         return !!_loc2_?_loc2_.stars:0;
      }
      
      private function handler_titanArtifactEvolve(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         if(param2.desc.artifactType == "spirit")
         {
            _signal_spiritsUpdate.dispatch();
         }
      }
   }
}
