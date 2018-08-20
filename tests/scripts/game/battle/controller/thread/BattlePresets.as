package game.battle.controller.thread
{
   import battle.BattleConfig;
   import game.battle.controller.BattleController;
   
   public class BattlePresets
   {
       
      
      private var _isReplay:Boolean;
      
      private var _showBothTeams:Boolean;
      
      private var _autoToggleable:Boolean;
      
      private var _auto:Boolean;
      
      private var _config:BattleConfig;
      
      private var _speedToggleOptions:Vector.<Number>;
      
      private var _speedToggleIndexOnStart:int = 1;
      
      public function BattlePresets(param1:Boolean, param2:Boolean, param3:Boolean, param4:BattleConfig, param5:Boolean = false)
      {
         _speedToggleOptions = new <Number>[0.25,1,4];
         super();
         this._isReplay = param1;
         this._showBothTeams = param5;
         this._autoToggleable = param2;
         this._auto = param3 || BattleController.DEFAULT_AUTO_BATTLE;
         this._config = param4;
      }
      
      public function get isReplay() : Boolean
      {
         return _isReplay;
      }
      
      public function get showBothTeams() : Boolean
      {
         return _showBothTeams;
      }
      
      public function get autoToggleable() : Boolean
      {
         return _autoToggleable;
      }
      
      public function get autoOnStart() : Boolean
      {
         return _auto;
      }
      
      public function get config() : BattleConfig
      {
         return _config;
      }
      
      public function get timeLimit() : int
      {
         return _config.battleDuration;
      }
      
      public function get speedToggleOptions() : Vector.<Number>
      {
         return _speedToggleOptions;
      }
      
      public function get speedToggleIndexOnStart() : int
      {
         return _speedToggleIndexOnStart;
      }
   }
}
