import 'package:graphview_plotter/core/app_exception.dart';
import 'package:graphview_plotter/app/model/graph_model.dart';
import 'package:graphview_plotter/network/rest_api_client.dart';
import 'package:graphview_plotter/network/rest_response.dart';

class Repository {
  Future<RestResponse<GraphModel>> fetchGraphDetails() async {
    try {
      final headers = {
        'accept': ' application/json, text/plain, /',
        'accept-language': ' en-GB,en;q=0.9',
        'cache-control': ' no-cache',
        'cookie':
            ' ga=GA1.1.1160982568.1719048726; intercom-id-fs0qt2hb=232ab74a-8e43-42d9-8b87-ee7df821c68c; intercom-session-fs0qt2hb=; intercom-device-id-fs0qt2hb=27e9a626-572f-42c8-a4ae-dccd0ae5bfa3; mp_9767498b11c1718d1052a6f285a8d323_mixpanel=%7B%22distinct_id%22%3A%20%22%24device%3A1903f49e6f33c4-0f5445cb604293-19525637-16a7f0-1903f49e6f33c4%22%2C%22%24device_id%22%3A%20%221903f49e6f33c4-0f5445cb604293-19525637-16a7f0-1903f49e6f33c4%22%2C%22%24initial_referrer%22%3A%20%22%24direct%22%2C%22%24initial_referring_domain%22%3A%20%22%24direct%22%2C%22mps%22%3A%20%7B%7D%2C%22mpso%22%3A%20%7B%22%24initial_referrer%22%3A%20%22%24direct%22%2C%22%24initial_referring_domain%22%3A%20%22%24direct%22%7D%2C%22mpus%22%3A%20%7B%7D%2C%22mpa%22%3A%20%7B%7D%2C%22mpu%22%3A%20%7B%7D%2C%22mpr%22%3A%20%5B%5D%2C%22_mpap%22%3A%20%5B%5D%7D; _ga_PJYC6438CL=GS1.1.1719048726.1.1.1719049112.0.0.0',
        'pragma': ' no-cache',
        'priority': ' u=1, i',
        'referer':
            ' https://0xppl.com/explorer?identifiers=42703,49257&build_identity_nodes=true',
        'sec-ch-ua':
            ' "Not/A)Brand";v="8", "Chromium";v="126", "Brave";v="126"',
        'sec-ch-ua-mobile': ' ?0',
        'sec-ch-ua-platform': ' "macOS"',
        'sec-fetch-dest': ' empty',
        'sec-fetch-mode': ' cors',
        'sec-fetch-site': ' same-origin',
        'sec-gpc': ' 1',
        'user-agent':
            ' Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36',
        'x-0xppl-client-session-id': ' 6b08e866-bcb9-4ec8-9644-db0a9b0ec7ee',
        'x-0xppl-device-id': ' 4d3c95b4-b0dc-454a-9a8b-1a47e5d2248a',
        'x-0xppl-request-id': ' a55b1b8b59d44436b4dd613eccc96558',
        'x-openreplay-sessiontoken':
            ' ljq1ard688ri.u8.lxq1iir3.GhdLFRCeh4pSnp5zsKHCQUaH5PewzhZFFAAgS1mAUk6b',
        'x-openreplay-sessionurl':
            ' https://openreplay.0xppl.com/2/session/2836167014243379294'
      };

      final response = await RestClient().request(
        url:
            'https://0xppl.com/api/v4/get_graph_explorer_unified?identifiers=42703%2C49257&build_identity_nodes=true&pusher_channel_id=1043ffa5-71c3-40fc-b949-65012654ca4c&request_id=a55b1b8b59d44436b4dd613eccc96558',
        requestType: RestMethodType.get,
        headers: headers,
      );
      if (response is AppException) {
        return RestResponse(exception: response);
      }
      return RestResponse(response: GraphModel.fromMap(response));
    } catch (e, st) {
      return RestResponse(
        exception: FatalException(exception: e, message: '', stackTrace: st),
      );
    }
  }
}
