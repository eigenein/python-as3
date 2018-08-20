package game.data.storage.rule
{
   public class TitanArenaRule
   {
       
      
      private var data:Object;
      
      private var _scorePerTitanAtk:int;
      
      private var _scorePerTitanDef:int;
      
      private var _pointsTotal_attack:int;
      
      private var _pointsTotal_defense:int;
      
      public function TitanArenaRule(param1:Object)
      {
         super();
         this.data = param1;
         _scorePerTitanAtk = param1.scorePerTitanAtk;
         _scorePerTitanDef = param1.scorePerTitanDef;
         _pointsTotal_attack = _scorePerTitanAtk * 5;
         _pointsTotal_defense = _scorePerTitanDef * 5;
      }
      
      public function get scorePerTitanAtk() : int
      {
         return _scorePerTitanAtk;
      }
      
      public function get scorePerTitanDef() : int
      {
         return _scorePerTitanDef;
      }
      
      public function get pointsTotal_attack() : int
      {
         return _pointsTotal_attack;
      }
      
      public function get pointsTotal_defense() : int
      {
         return _pointsTotal_defense;
      }
   }
}
