package game.mediator.gui.popup.arena
{
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   
   public class ArenaLogEntryVOProxy
   {
       
      
      private var _vo:ArenaBattleResultValueObject;
      
      public var displayedUser:UserInfo;
      
      public var isDefensiveBattle:Boolean;
      
      public var win:Boolean;
      
      public var place:int;
      
      public var placeDirection:int;
      
      public var attackers:Vector.<UnitEntryValueObject>;
      
      public var defenders:Vector.<UnitEntryValueObject>;
      
      public var attacker:UserInfo;
      
      public var defender:UserInfo;
      
      public var info:String;
      
      public function ArenaLogEntryVOProxy(param1:ArenaBattleResultValueObject)
      {
         super();
         this._vo = param1;
      }
      
      public static function create(param1:ArenaBattleResultValueObject, param2:Player) : ArenaLogEntryVOProxy
      {
         var _loc3_:ArenaLogEntryVOProxy = new ArenaLogEntryVOProxy(param1);
         var _loc4_:String = "";
         _loc4_ = _loc4_ + (" " + param1.userId);
         _loc4_ = _loc4_ + ("attacked" + param1.typeId);
         _loc3_.isDefensiveBattle = param1.typeId == param2.id;
         _loc4_ = _loc4_ + (" d=" + _loc3_.isDefensiveBattle);
         _loc3_.win = param1.win != _loc3_.isDefensiveBattle;
         _loc4_ = _loc4_ + (" w=" + param1.win);
         _loc3_.displayedUser = !!_loc3_.isDefensiveBattle?param1.attacker:param1.defender;
         if(_loc3_.win && !_loc3_.isDefensiveBattle)
         {
            _loc3_.placeDirection = 1;
         }
         if(!_loc3_.win && _loc3_.isDefensiveBattle)
         {
            _loc3_.placeDirection = -1;
         }
         if(_loc3_.placeDirection != 0)
         {
            _loc3_.place = _loc3_.placeDirection > 0?param1.newPlace:int(param1.oldPlace);
         }
         _loc4_ = _loc4_ + (" nP=" + param1.newPlace);
         _loc4_ = _loc4_ + (" oP=" + param1.oldPlace);
         _loc3_.info = _loc4_;
         _loc3_.attackers = param1.result.attackers;
         _loc3_.defenders = param1.result.defenders;
         _loc3_.attacker = param1.attacker;
         _loc3_.defender = param1.defender;
         return _loc3_;
      }
      
      public function get source() : ArenaBattleResultValueObject
      {
         return _vo;
      }
   }
}
