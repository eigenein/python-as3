package game.mediator.gui.popup.arena
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.arena.ArenaRewardDescription;
   import game.model.user.inventory.InventoryItem;
   
   public class ArenaRulesPopupValueObject
   {
       
      
      private var _arenaPlace:int;
      
      private var _grandPlace:int;
      
      private var _myReward:Vector.<InventoryItem>;
      
      private var _rewardsByPlace:Vector.<ArenaRewardDescription>;
      
      public function ArenaRulesPopupValueObject(param1:int, param2:int)
      {
         var _loc3_:int = 0;
         super();
         _arenaPlace = param1;
         _grandPlace = param2;
         if(_arenaPlace > 0 && _grandPlace > 0)
         {
            _loc3_ = Math.min(_arenaPlace,_grandPlace);
         }
         else if(_grandPlace > 0)
         {
            _loc3_ = _grandPlace;
         }
         else
         {
            _loc3_ = _arenaPlace;
         }
         _myReward = DataStorage.arena.getRewardByPlace(_loc3_).arenaDailyReward.outputDisplay;
         _rewardsByPlace = DataStorage.arena.getRewardList();
         _rewardsByPlace.sort(_sortRewards);
      }
      
      public function get arenaPlace() : String
      {
         if(_arenaPlace > 0)
         {
            return String(_arenaPlace);
         }
         return "?";
      }
      
      public function get grandPlace() : String
      {
         if(_grandPlace > 0)
         {
            return String(_grandPlace);
         }
         return "?";
      }
      
      public function get myReward() : Vector.<InventoryItem>
      {
         return _myReward;
      }
      
      public function get rewardsByPlace() : Vector.<ArenaRewardDescription>
      {
         return _rewardsByPlace;
      }
      
      public function getArenaRewardLabel() : String
      {
         if(_grandPlace > 0 && _grandPlace < _arenaPlace)
         {
            return Translate.translateArgs("UI_POPUP_ARENA_LABEL_REWARD_GRAND_PLACE",_grandPlace);
         }
         return Translate.translate("UI_POPUP_ARENA_LABEL_REWARD");
      }
      
      public function getGrandRewardLabel() : String
      {
         if(_arenaPlace < _grandPlace || _grandPlace > 0 == false)
         {
            return Translate.translateArgs("UI_POPUP_ARENA_LABEL_REWARD_ARENA_PLACE",_arenaPlace);
         }
         return Translate.translate("UI_POPUP_ARENA_LABEL_REWARD");
      }
      
      private function _sortRewards(param1:ArenaRewardDescription, param2:ArenaRewardDescription) : int
      {
         return param1.placeFrom - param2.placeFrom;
      }
   }
}
