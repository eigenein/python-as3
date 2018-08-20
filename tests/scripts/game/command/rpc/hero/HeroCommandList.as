package game.command.rpc.hero
{
   import game.command.CommandManager;
   import game.command.rpc.artifact.CommandArtifactChestOpen;
   import game.command.rpc.artifact.CommandArtifactFragmentBuy;
   import game.command.rpc.artifact.CommandHeroArtifactEvolve;
   import game.command.rpc.artifact.CommandHeroArtifactLevelUp;
   import game.data.cost.CostData;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.skills.SkillDescription;
   import game.data.storage.skin.SkinDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class HeroCommandList
   {
       
      
      private var commandManager:CommandManager;
      
      public function HeroCommandList(param1:CommandManager)
      {
         super();
         this.commandManager = param1;
      }
      
      public function heroCraft(param1:HeroDescription) : CommandHeroCraft
      {
         var _loc2_:CommandHeroCraft = new CommandHeroCraft(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function heroEvolve(param1:PlayerHeroEntry) : CommandHeroEvolve
      {
         var _loc2_:CommandHeroEvolve = new CommandHeroEvolve(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function heroInsertItem(param1:PlayerHeroEntry, param2:int) : CommandHeroInsertItem
      {
         var _loc3_:CommandHeroInsertItem = new CommandHeroInsertItem(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function heroEnchantItem(param1:PlayerHeroEntry, param2:int, param3:CostData) : CommandHeroEnchantItem
      {
         var _loc4_:CommandHeroEnchantItem = new CommandHeroEnchantItem(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function heroEnchantRune(param1:PlayerHeroEntry, param2:int, param3:CostData) : CommandHeroEnchantRune
      {
         var _loc4_:CommandHeroEnchantRune = new CommandHeroEnchantRune(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function heroEnchantRuneStarmoney(param1:PlayerHeroEntry, param2:int) : CommandHeroEnchantRuneStaromoney
      {
         var _loc3_:CommandHeroEnchantRuneStaromoney = new CommandHeroEnchantRuneStaromoney(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function heroPromote(param1:PlayerHeroEntry) : CommandHeroPromote
      {
         var _loc2_:CommandHeroPromote = new CommandHeroPromote(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function heroSkillUpgrade(param1:PlayerHeroEntry, param2:SkillDescription, param3:Boolean) : CommandHeroSkillUpgrade
      {
         var _loc4_:CommandHeroSkillUpgrade = new CommandHeroSkillUpgrade(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function heroSkinUpgrade(param1:PlayerHeroEntry, param2:SkinDescription, param3:Boolean) : CommandHeroSkinUpgrade
      {
         var _loc4_:CommandHeroSkinUpgrade = new CommandHeroSkinUpgrade(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function heroSkinChange(param1:PlayerHeroEntry, param2:SkinDescription, param3:Boolean) : CommandHeroSkinChange
      {
         var _loc4_:CommandHeroSkinChange = new CommandHeroSkinChange(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function heroConsumableUseXP_add(param1:Player, param2:PlayerHeroEntry, param3:ConsumableDescription, param4:int) : void
      {
         var _loc5_:CommandHeroConsumableUseXP = CommandHeroConsumableUseXPAggregator.addCommand(param1,param2,param3,param4);
         if(!_loc5_)
         {
         }
      }
      
      public function heroConsumableUseXP_flush() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Vector.<CommandHeroConsumableUseXP> = CommandHeroConsumableUseXPAggregator.flush();
         var _loc2_:int = _loc1_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            commandManager.executeRPCCommand(_loc1_[_loc3_]);
            _loc3_++;
         }
      }
      
      public function heroTitanGiftLevelUp(param1:PlayerHeroEntry, param2:CostData) : CommandHeroTitanGiftLevelUp
      {
         var _loc3_:CommandHeroTitanGiftLevelUp = new CommandHeroTitanGiftLevelUp(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function heroTitanGiftDrop(param1:PlayerHeroEntry) : CommandHeroTitanGiftDrop
      {
         var _loc2_:CommandHeroTitanGiftDrop = new CommandHeroTitanGiftDrop(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function heroArtifactEvolve(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : CommandHeroArtifactEvolve
      {
         var _loc3_:CommandHeroArtifactEvolve = new CommandHeroArtifactEvolve(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function heroArtifactLevelUp(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : CommandHeroArtifactLevelUp
      {
         var _loc3_:CommandHeroArtifactLevelUp = new CommandHeroArtifactLevelUp(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function artifactFragmentBuy(param1:ArtifactDescription, param2:uint) : CommandArtifactFragmentBuy
      {
         var _loc3_:CommandArtifactFragmentBuy = new CommandArtifactFragmentBuy(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function artifactChestOpen(param1:Player, param2:uint, param3:Boolean) : CommandArtifactChestOpen
      {
         var _loc4_:CommandArtifactChestOpen = new CommandArtifactChestOpen(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
   }
}
