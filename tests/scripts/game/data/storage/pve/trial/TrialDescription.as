package game.data.storage.pve.trial
{
   import game.data.storage.DataStorage;
   import game.data.storage.pve.BattleWave;
   import game.data.storage.pve.PVEBattleDescription;
   
   public class TrialDescription extends PVEBattleDescription
   {
       
      
      private var _type:TrialTypeDescription;
      
      private var _index:int;
      
      private var _teamLevel:int;
      
      private var _attackersEffects:Vector.<String>;
      
      private var _defendersEffects:Vector.<String>;
      
      public function TrialDescription(param1:Object)
      {
         super();
         _id = param1.id;
         _type = DataStorage.trial.getType(param1.type);
         _index = param1.index;
         _teamLevel = param1.teamLevel;
         _waves = new Vector.<BattleWave>();
         if(param1.effects)
         {
            _attackersEffects = !!param1.effects.attackers?Vector.<String>(param1.effects.attackers):new Vector.<String>(0);
            _defendersEffects = !!param1.effects.defenders?Vector.<String>(param1.effects.defenders):new Vector.<String>(0);
         }
         else
         {
            _defendersEffects = new Vector.<String>(0);
            _attackersEffects = new Vector.<String>(0);
         }
         parseWaves(param1.waves);
      }
      
      public function get type() : TrialTypeDescription
      {
         return _type;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get teamLevel() : int
      {
         return _teamLevel;
      }
      
      public function get attackersEffects() : Vector.<String>
      {
         return _attackersEffects;
      }
      
      public function get defendersEffects() : Vector.<String>
      {
         return _defendersEffects;
      }
   }
}
