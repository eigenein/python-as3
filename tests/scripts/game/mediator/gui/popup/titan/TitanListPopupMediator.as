package game.mediator.gui.popup.titan
{
   import game.data.storage.DataStorage;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.titan.evolve.TitanEvolveCostPopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanEntry;
   import game.view.popup.PopupBase;
   
   public class TitanListPopupMediator extends PopupMediator
   {
       
      
      private var _data:Vector.<PlayerTitanListValueObject>;
      
      public function TitanListPopupMediator(param1:Player)
      {
         super(param1);
         updateData();
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
         _data = null;
      }
      
      public function get data() : Vector.<PlayerTitanListValueObject>
      {
         return _data;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanListPopup(this);
         return _popup;
      }
      
      public function action_select(param1:PlayerTitanListValueObject) : void
      {
         var _loc2_:* = null;
         if(param1.canCraft && !param1.owned)
         {
            _loc2_ = new TitanEvolveCostPopupMediator(player,param1.titan);
            _loc2_.open(popup.stashParams);
         }
         else if(param1.playerEntry)
         {
            new TitanPopupMediator(player,param1.playerEntry).open(popup.stashParams);
         }
         else
         {
            new TitanDescriptionPopupMediator(player,param1).open(popup.stashParams);
         }
      }
      
      protected function getHeroesList() : Vector.<TitanDescription>
      {
         return DataStorage.titan.getPlayableTitans();
      }
      
      private function updateData() : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc6_:* = null;
         _data = new Vector.<PlayerTitanListValueObject>();
         var _loc4_:Vector.<TitanDescription> = getHeroesList();
         var _loc2_:int = _loc4_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = _loc4_[_loc5_];
            if(_loc3_.isPlayable)
            {
               _loc1_ = player.titans.getById(_loc3_.id);
               _loc6_ = new PlayerTitanListValueObject(_loc3_,player);
               _data.push(_loc6_);
            }
            _loc5_++;
         }
         _data.sort(PlayerTitanListValueObject.sort);
      }
   }
}
