package game.mediator.gui.popup.titan
{
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.titan.TitanArtifactListPopup;
   
   public class TitanArtifactListPopupMediator extends PopupMediator
   {
       
      
      private var _data:Vector.<PlayerTitanListValueObject>;
      
      public function TitanArtifactListPopupMediator(param1:Player)
      {
         super(param1);
         filterData();
      }
      
      public function get data() : Vector.<PlayerTitanListValueObject>
      {
         return _data;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArtifactListPopup(this);
         return _popup;
      }
      
      public function action_select(param1:PlayerTitanListValueObject) : void
      {
         PopupList.instance.dialog_titan_artifacts(param1.titan,null,Stash.click("titan_artifacts",_popup.stashParams));
      }
      
      private function filterData() : void
      {
         var _loc3_:int = 0;
         if(_data)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _data;
            for each(var _loc2_ in _data)
            {
               _loc2_.dispose();
            }
         }
         _data = new Vector.<PlayerTitanListValueObject>();
         var _loc4_:Vector.<PlayerTitanEntry> = player.titans.getList();
         var _loc1_:int = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _data.push(new PlayerTitanArtifactListValueObject(_loc4_[_loc3_].titan,player));
            _loc3_++;
         }
         _data.sort(PlayerTitanListValueObject.sort);
      }
   }
}
