package game.mechanics.clan_war.mediator.log
{
   public class ClanWarLogValueObject
   {
      
      public static const TYPE_HEADER:int = 0;
      
      public static const TYPE_CONTENT:int = 1;
      
      public static const TYPE_FOOTER:int = 2;
       
      
      private var _mediator:ClanWarLogPopupMediator;
      
      private var _war:ClanWarLogItem;
      
      private var _seasonEnd:ClanWarLogSeasonEndData;
      
      private var _type:int;
      
      public function ClanWarLogValueObject(param1:ClanWarLogPopupMediator, param2:ClanWarLogItem, param3:int, param4:ClanWarLogSeasonEndData = null)
      {
         super();
         this._mediator = param1;
         this._war = param2;
         this._type = param3;
         this._seasonEnd = param4;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get item() : ClanWarLogItem
      {
         return _war;
      }
      
      public function get seasonEnd() : ClanWarLogSeasonEndData
      {
         return _seasonEnd;
      }
      
      public function action_select() : void
      {
         if(_war)
         {
            _mediator.action_select(_war);
         }
      }
      
      public function action_openMemberList_attacker() : void
      {
         if(_war)
         {
            _mediator.action_openMemberList_attacker(_war);
         }
      }
      
      public function action_openMemberList_defender() : void
      {
         if(_war)
         {
            _mediator.action_openMemberList_defender(_war);
         }
      }
   }
}
