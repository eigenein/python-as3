package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.clan_war.model.ClanWarSlotValueObject;
   
   public class CommandClanWarAttack extends RPCCommandBase
   {
       
      
      private var _slot:ClanWarSlotValueObject;
      
      public function CommandClanWarAttack(param1:ClanWarSlotValueObject, param2:Vector.<UnitDescription>)
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get slot() : ClanWarSlotValueObject
      {
         return _slot;
      }
      
      public function get battle() : Object
      {
         return result.body.battle;
      }
      
      public function get startBattleError() : String
      {
         return result.body.error;
      }
      
      public function get endTime() : int
      {
         return result.body.endTime;
      }
   }
}
