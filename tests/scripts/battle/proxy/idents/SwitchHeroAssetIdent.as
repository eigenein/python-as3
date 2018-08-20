package battle.proxy.idents
{
   import battle.data.BattleHeroDescription;
   import flash.Boot;
   
   public class SwitchHeroAssetIdent
   {
       
      
      public var prefix:String;
      
      public var heroDescription:BattleHeroDescription;
      
      public var doRemoveOnEnemyTeamEmpty:Boolean;
      
      public var doRemoveOnDeath:Boolean;
      
      public function SwitchHeroAssetIdent(param1:BattleHeroDescription = undefined, param2:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         doRemoveOnEnemyTeamEmpty = true;
         doRemoveOnDeath = true;
         heroDescription = param1;
         prefix = param2;
      }
   }
}
