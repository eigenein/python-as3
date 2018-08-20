package game.mediator.gui.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.command.intern.OpenHeroPopUpCommand;
   import game.command.rpc.hero.CommandHeroCraft;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.evolve.HeroEvolveCostPopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.hero.HeroListPopup;
   import idv.cjcat.signals.Signal;
   
   public class HeroListPopupMediator extends PopupMediator
   {
      
      public static const TAB_ALL:String = "all";
      
      public static const TAB_FRONT:String = "front";
      
      public static const TAB_MID:String = "mid";
      
      public static const TAB_BACK:String = "back";
       
      
      private var selectedTabIndex:int;
      
      private var _data:Vector.<PlayerHeroListValueObject>;
      
      private var _tabs:Vector.<String>;
      
      private var _signal_updateData:Signal;
      
      public function HeroListPopupMediator(param1:Player)
      {
         super(param1);
         _tabs = new Vector.<String>();
         _tabs[0] = "all";
         _tabs[1] = "front";
         _tabs[2] = "mid";
         _tabs[3] = "back";
         _signal_updateData = new Signal();
         filterData();
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         var _loc3_:int = 0;
         var _loc2_:* = _data;
         for each(var _loc1_ in _data)
         {
            _loc1_.dispose();
         }
         _tabs = null;
         _data = null;
         _signal_updateData.clear();
         _signal_updateData = null;
      }
      
      public function get data() : Vector.<PlayerHeroListValueObject>
      {
         return _data;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      public function get signal_updateData() : Signal
      {
         return _signal_updateData;
      }
      
      public function get title() : String
      {
         return Translate.translate("UI_DIALOG_HERO_LIST_TITLE");
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroListPopup(this);
         return _popup;
      }
      
      override public function close() : void
      {
         super.close();
      }
      
      public function action_select(param1:PlayerHeroListValueObject) : void
      {
         var _loc2_:* = null;
         if(param1.canCraft && !param1.owned)
         {
            _loc2_ = new HeroEvolveCostPopupMediator(player,param1.hero);
            PopUpManager.addPopUp(_loc2_.createPopup());
         }
         else
         {
            addHeroPopup(param1.hero);
         }
      }
      
      public function action_heroInfo(param1:PlayerHeroListValueObject) : void
      {
         addHeroPopup(param1.hero);
      }
      
      protected function getHeroesList() : Vector.<HeroDescription>
      {
         return DataStorage.hero.getPlayableHeroes();
      }
      
      private function filterData() : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:* = null;
         _data = new Vector.<PlayerHeroListValueObject>();
         var _loc1_:Vector.<HeroDescription> = getHeroesList();
         var _loc2_:int = _loc1_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc5_];
            if(!(!_loc4_.isPlayable || _tabs[selectedTabIndex] != "all" && _loc4_.battleOrderIndex != selectedTabIndex))
            {
               _loc3_ = player.heroes.getById(_loc4_.id);
               _loc6_ = new PlayerHeroListValueObject(_loc4_,player);
               _data.push(_loc6_);
            }
            _loc5_++;
         }
         _data.sort(PlayerHeroListValueObject.sort);
      }
      
      private function addHeroPopup(param1:HeroDescription) : void
      {
         new OpenHeroPopUpCommand(player,param1,Stash.click("heroes_list",_popup.stashParams)).execute();
      }
      
      private function onHeroCraft(param1:CommandHeroCraft) : void
      {
         addHeroPopup(param1.hero);
      }
      
      public function action_tabSelect(param1:int) : void
      {
         selectedTabIndex = param1;
         filterData();
         _signal_updateData.dispatch();
      }
   }
}
