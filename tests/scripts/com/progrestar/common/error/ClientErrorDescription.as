package com.progrestar.common.error
{
   public class ClientErrorDescription
   {
      
      public static const ERROR_KEY_GLOBAL_UNHANDLED_ERROR:String = "Global:UnhandledError";
      
      public static const ERROR_KEY_ASSET_LOAD_FAILED:String = "AssetLoad:Failed";
      
      public static const ERROR_KEY_ASSET_LOAD_SUCCEEDED:String = "AssetLoad:Succeeded";
      
      public static const ERROR_KEY_ASSET_LOAD_ERROR:String = "AssetLoad:Error";
      
      public static const ERROR_KEY_TEXTURE_ERROR:String = "Texture Error #";
      
      public static const ERROR_KEY_MC_FACTORY_FAILED:String = "McFactory:Failed";
      
      public static const ERROR_KEY_RPC_CLIENT_JSON_ERROR:String = "RPCClient:JSONError";
      
      public static const ERROR_KEY_RPC_CLIENT_IO_ERROR:String = "RPCClient:IOError";
      
      public static const ERROR_KEY_RPC_CLIENT_SECURITY_ERROR:String = "RPCClient:SecurityError";
      
      public static const ERROR_KEY_SOCIAL_NETWORK_FAILED:String = "SocialNetwork:Failed";
      
      public static const ERROR_KEY_PVE_INVALID_BATTLE:String = "PVE:InvalidBattle";
      
      public static const ERROR_KEY_PVE_INVALID_TITAN_BATTLE:String = "PVE:InvalidTitanBattle";
      
      public static const ERROR_KEY_PVP_INVALID_CLANWAR_BATTLE:String = "PVP:InvalidClanWarBattle";
      
      public static const ERROR_KEY_PVP_INVALID_ARENA_BATTLE:String = "PVP:InvalidArenaBattle";
      
      public static const ERROR_KEY_PVE_HACKED_BATTLE:String = "PVE:HackedBattle";
      
      public static const ERROR_KEY_PVP_HACKED_BATTLE:String = "PVP:HackedBattle";
      
      public static const ERROR_KEY_PVE_INCORRECT_VERSION:String = "PVE:IncorrectVersion";
      
      public static const ERROR_KEY_DESYNC_REFILLABLE:String = "Desync:Refillable";
      
      public static const ERROR_KEY_RPC_CLIENT_RESET_DAY_ERROR:String = "RPCClient:ResetDayError";
      
      private static var errorsInSession:int = 0;
       
      
      private var _numInSession:int;
      
      private var _errorKey:String;
      
      private var _request:String;
      
      private var _response:String;
      
      public function ClientErrorDescription(param1:String, param2:String = null, param3:String = null)
      {
         super();
         errorsInSession = errorsInSession + 1;
         _numInSession = errorsInSession + 1;
         _errorKey = param1;
         _request = param2;
         _response = param3;
      }
      
      public function get numInSession() : int
      {
         return _numInSession;
      }
      
      public function get errorKey() : String
      {
         return _errorKey;
      }
      
      public function get request() : String
      {
         return _request;
      }
      
      public function get response() : String
      {
         return _response;
      }
   }
}
