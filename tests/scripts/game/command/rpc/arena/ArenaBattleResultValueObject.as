package game.command.rpc.arena
{
   import game.battle.controller.MultiBattleResult;
   import game.mediator.gui.popup.arena.BattleResultValueObject;
   import game.model.user.UserInfo;
   
   public class ArenaBattleResultValueObject extends BattleResultValueObject
   {
       
      
      public var replayId:String;
      
      public var oldPlace:int;
      
      public var newPlace:int;
      
      public var invalid:Boolean;
      
      public var typeId:String;
      
      public var userId:String;
      
      public var defender:UserInfo;
      
      public var attacker:UserInfo;
      
      public function ArenaBattleResultValueObject()
      {
         super();
      }
      
      override public function set result(param1:MultiBattleResult) : void
      {
         _result = param1;
      }
   }
}
