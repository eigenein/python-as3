package game.view.popup.clan.activitystats
{
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.model.user.clan.ClanMemberValueObject;
   import idv.cjcat.signals.Signal;
   
   public class ClanGiftStatsVO
   {
       
      
      private var _signal_select:Signal;
      
      private var _property_selected:BooleanPropertyWriteable;
      
      private var _property_selectable:BooleanPropertyWriteable;
      
      private var _id:String;
      
      private var _likes_activity:int;
      
      private var _likes_dungeonActivity:int;
      
      private var _property_giftsReceived:IntPropertyWriteable;
      
      public var member:ClanMemberValueObject;
      
      public var isPlayer:Boolean;
      
      private var _playerCanSend:Boolean;
      
      public function ClanGiftStatsVO(param1:Object, param2:int, param3:Boolean)
      {
         _signal_select = new Signal(ClanGiftStatsVO);
         _property_selected = new BooleanPropertyWriteable();
         _property_selectable = new BooleanPropertyWriteable();
         _property_giftsReceived = new IntPropertyWriteable();
         super();
         this._playerCanSend = param3;
         this._property_giftsReceived.value = param2;
         _id = param1.id;
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get property_selected() : BooleanPropertyWriteable
      {
         return _property_selected;
      }
      
      public function get property_selectable() : BooleanPropertyWriteable
      {
         return _property_selectable;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get likes_activity() : int
      {
         return _likes_activity;
      }
      
      public function get likes_dungeonActivity() : int
      {
         return _likes_dungeonActivity;
      }
      
      public function get likes_total() : int
      {
         return _likes_dungeonActivity + _likes_activity;
      }
      
      public function get property_giftsReceived() : IntProperty
      {
         return _property_giftsReceived;
      }
      
      public function get giftsReceived() : int
      {
         return _property_giftsReceived.value;
      }
      
      public function get nickname() : String
      {
         return !!member?member.nickname:"";
      }
      
      public function get playerCanSend() : Boolean
      {
         return _playerCanSend;
      }
      
      public function action_check(param1:Boolean) : void
      {
         _property_selected.value = param1;
         _signal_select.dispatch(this);
      }
      
      public function action_addGift(param1:int) : void
      {
         _property_giftsReceived.value = _property_giftsReceived.value + param1;
      }
      
      public function setLikesReceived_activity(param1:int) : void
      {
         _likes_activity = param1;
      }
      
      public function setLikesReceived_dungeon(param1:int) : void
      {
         _likes_dungeonActivity = param1;
      }
   }
}
