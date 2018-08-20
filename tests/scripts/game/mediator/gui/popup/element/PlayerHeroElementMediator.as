package game.mediator.gui.popup.element
{
   import battle.BattleStats;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.titan.TitanGiftDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.watch.PlayerHeroWatcherEntry;
   import game.view.gui.tutorial.Tutorial;
   import org.osflash.signals.Signal;
   
   public class PlayerHeroElementMediator
   {
       
      
      private var player:Player;
      
      private var hero:PlayerHeroEntry;
      
      private var watch:PlayerHeroWatcherEntry;
      
      private var _signal_updateTitanGiftLevelUpAvaliable:Signal;
      
      public function PlayerHeroElementMediator(param1:Player)
      {
         _signal_updateTitanGiftLevelUpAvaliable = new Signal();
         super();
         this.player = param1;
      }
      
      public function get heroTitanGiftLevel() : int
      {
         return hero.titanGiftLevel;
      }
      
      public function get heroGiftLevelMin() : int
      {
         return 0;
      }
      
      public function get heroGiftLevelMax() : int
      {
         var _loc1_:TitanGiftDescription = DataStorage.titanGift.getTitanGiftWithMaxLevel();
         return !!_loc1_?_loc1_.level:0;
      }
      
      public function get battleStatsCurrent() : BattleStats
      {
         var _loc1_:TitanGiftDescription = titanGiftCurrent;
         return !!_loc1_?_loc1_.getBattleStatByBaseStat(hero.hero.mainStat.name):null;
      }
      
      public function get titanGiftCurrent() : TitanGiftDescription
      {
         return DataStorage.titanGift.getTitanGiftByLevel(hero.titanGiftLevel);
      }
      
      public function get actionAvailable_titanGiftLevelUp() : Boolean
      {
         return watch.titanGiftLevelUpAvaliable;
      }
      
      public function get signal_updateTitanGiftLevelUpAvaliable() : Signal
      {
         return _signal_updateTitanGiftLevelUpAvaliable;
      }
      
      public function setHero(param1:PlayerHeroEntry) : void
      {
         if(watch)
         {
            watch.signal_updateTitanGiftLevelUpAvaliable.remove(handler_updateTitanGiftLevelUpAvaliable);
            watch = null;
         }
         this.hero = param1;
         if(param1)
         {
            watch = player.heroes.watcher.getHeroWatch(param1.hero);
            watch.signal_updateTitanGiftLevelUpAvaliable.add(handler_updateTitanGiftLevelUpAvaliable);
         }
      }
      
      private function handler_updateTitanGiftLevelUpAvaliable(param1:PlayerHeroWatcherEntry) : void
      {
         signal_updateTitanGiftLevelUpAvaliable.dispatch();
      }
      
      public function action_navigate_to_clan() : void
      {
         var _loc1_:PopupStashEventParams = new PopupStashEventParams();
         _loc1_.windowName = "dialog_hero";
         if(Tutorial.flags.clanScreenIsIntroduced)
         {
            PopupList.instance.dialog_elements(hero.hero,_loc1_);
         }
         else
         {
            Game.instance.navigator.navigateToMechanic(MechanicStorage.TITAN_GIFT,_loc1_);
         }
      }
      
      public function action_navigate_to_titan() : void
      {
         var _loc1_:PopupStashEventParams = new PopupStashEventParams();
         _loc1_.windowName = "dialog_hero";
         Game.instance.navigator.navigateToTitans(_loc1_);
      }
   }
}
