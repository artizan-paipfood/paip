#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  //***************************************************************************************
  //CUSTOM CODE     
  // Criar um mutex para garantir instância única
  HANDLE hMutex = CreateMutexW(NULL, TRUE, L"PaipFoodGestorMutex");
  if (GetLastError() == ERROR_ALREADY_EXISTS) {
    // Se o mutex já existe, significa que outra instância está rodando
    MessageBoxW(NULL, L"Paip Food is already running", L"Info", MB_OK | MB_ICONWARNING);
    return 0;
  }
  //***************************************************************************************

  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.Create(L"manager", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }
  //***************************************************************************************
  //CUSTOM CODE
  // Liberar o mutex quando a aplicação for fechada
  if (hMutex) {
    ReleaseMutex(hMutex);
    CloseHandle(hMutex);
  }
  //***************************************************************************************

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
