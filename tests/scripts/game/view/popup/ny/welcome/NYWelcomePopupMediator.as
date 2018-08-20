package game.view.popup.ny.welcome
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.gui.homescreen.NYButtonHoverSound;
   import game.view.popup.PopupBase;
   import game.view.popup.activity.SpecialQuestEventPopupMediator;
   import game.view.popup.ny.NYPopupMediatorBase;
   import game.view.popup.ny.rating.NYRatingPopupMediator;
   import idv.cjcat.signals.Signal;
   
   public class NYWelcomePopupMediator extends NYPopupMediatorBase
   {
      
      private static var _music:NYButtonHoverSound;
       
      
      public var signal_giftsToOpenChange:Signal;
      
      public function NYWelcomePopupMediator(param1:Player)
      {
         signal_giftsToOpenChange = new Signal();
         super(param1);
         music.nyWindowOpen();
         param1.ny.signal_giftsToOpenChange.add(handler_giftsToOpenChange);
      }
      
      public static function get music() : NYButtonHoverSound
      {
         if(!_music)
         {
            _music = new NYButtonHoverSound(0.5,1.5,AssetStorage.sound.winterTreeHover);
         }
         return _music;
      }
      
      override protected function dispose() : void
      {
         music.nyWindowClosed();
         player.ny.signal_giftsToOpenChange.remove(handler_giftsToOpenChange);
         super.dispose();
      }
      
      public function get giftsToOpenAvaliable() : Boolean
      {
         return player.ny.giftsToOpen > 0;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new NYWelcomePopup(this);
         return _popup;
      }
      
      public function action_showSpecialQuests() : void
      {
         new SpecialQuestEventPopupMediator(GameModel.instance.player).open(Stash.click("special_quests",_popup.stashParams));
      }
      
      public function action_showNYTreeUpgrade() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.NY2018_TREE,Stash.click("tree",_popup.stashParams));
      }
      
      public function action_showNYGifts() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.NY2018_GIFTS,Stash.click("gifts",_popup.stashParams));
      }
      
      public function action_showRating() : void
      {
         new NYRatingPopupMediator(GameModel.instance.player).open(Stash.click("rating",_popup.stashParams));
      }
      
      private function handler_giftsToOpenChange() : void
      {
         signal_giftsToOpenChange.dispatch();
      }
   }
}
