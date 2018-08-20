package game.command.rpc.hero
{
   import com.progrestar.common.Logger;
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import flash.utils.getTimer;
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.SkillTier;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.skills.SkillDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroSkillUpgrade extends CostCommand
   {
       
      
      private var hero:PlayerHeroEntry;
      
      private var _skill:SkillDescription;
      
      public function CommandHeroSkillUpgrade(param1:PlayerHeroEntry, param2:SkillDescription, param3:Boolean)
      {
         super();
         this.isImmediate = param3;
         this._skill = param2;
         this.hero = param1;
         rpcRequest = new RpcRequest("heroUpgradeSkill");
         rpcRequest.writeParam("heroId",param1.hero.id);
         rpcRequest.writeParam("skill",param2.tier);
      }
      
      public function get skill() : SkillDescription
      {
         return _skill;
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc3_:* = param1.levelData.level.level >= MechanicStorage.SKILLS.teamLevel;
         var _loc2_:SkillTier = DataStorage.enum.getbyId_SkillTier(skill.tier);
         _cost = DataStorage.level.getSkillLevelCost(hero.skillData.getLevelByTier(_loc2_.id).level,_loc2_.id);
         var _loc4_:CommandRequirement = super.prerequisiteCheck(param1);
         if(!_loc3_ || !hero.canUpgradeSkill(skill))
         {
            _loc4_.invalid = true;
         }
         if(param1.refillable.skillpoints.value <= 0)
         {
            _loc4_.invalid = true;
         }
         return _loc4_;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.refillable.spend(param1.refillable.skillpoints,1);
         param1.heroes.heroUpgradeSkill(hero,skill);
         super.clientExecute(param1);
      }
      
      override public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
         super.onRpc_errorHandler(param1);
         var _loc2_:Object = param1.response.error;
         if(_loc2_.name == "NotEnough" && _loc2_.description.indexOf("Refillable 2") == 0)
         {
            Logger.getLogger("DesyncRefillable").error(["error:" + _loc2_.description,"clientTimestamp:" + GameTimer.instance.currentServerTime,"timeFromLogin:" + GameTimer.instance.timeFromLogin,"timeFromLoginUndistorted:" + GameTimer.instance.timeFromLoginUndistorted,"timeFromLoginGetTimer:" + GameTimer.instance.timeFromLoginGetTimer,"getTimer:" + getTimer(),"valueAfter:" + GameModel.instance.player.refillable.skillpoints.value,"timeLeft:" + GameModel.instance.player.refillable.skillpoints.refillTimeLeft,"lastRefill:" + GameModel.instance.player.refillable.skillpoints.lastRefill,"loginTime:" + GameTimer.instance.loginTime,"initTime:" + GameTimer.instance.initTime,"localTime:" + new Date().time / 1000,"flexTime:" + GameTimer.instance.serverTime.toString()].join(", "));
         }
      }
   }
}
